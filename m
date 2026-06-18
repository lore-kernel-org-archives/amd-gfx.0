Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA0ACD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 12:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BFC10F2AC;
	Thu, 18 Jun 2026 12:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwBByEg7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6CE10EE09
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 12:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxwKRnotTS57ZcHXDDgzmjxNhg39JNWMn2cKqhGkcIGKhJBKex1jGUFMF0TD64O4L/SiaZKUCq0RrzRZsq3UYK2hg/HlKAOY/0lXcjXpuMGBsTo9VU7LDw4wkEGg3nSFjJ8UGXlcW3FoFm8EKOap8mcbhNFkG24y3ZwZqBJMkRse3hjAcBmQCcwmBDICgyPhk9wXs4f/Ee4/+hXDtxwgG4xpLAKC3XpvpI0T2qSpLcRCEMJNnj5uGi1F0gIH3SrnpSNfbQa9Y7Yba5/5d5LYJ38C2KCVZNksP/o2jMEpVpbqnddMJWrewwcIVvqabhEJznVJ/NTpAPubBhpURn8gLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IXsV98FgKQYIo2EHA77C0vDBhZPG7y/02tzjRDA1jc=;
 b=veICCDqeYvY3QyR3hfaxm8xzu4WRbqwkx0BbBnkROp5yTyjunfBJ35nm1dc0AgluWPROI5BZAVzojj5T6lH4C6CSoaSzazb5ct+SyuFfoBIajgt23FjPS3BmKv0MYRWq9ocw+lsQlg2JJaFI/yWx8ZylGqZZYCHDYbGb0hf4w26vMSLxKBXOI8ILJomB13bQheleQmdB5A5rdStZ2Yaw3ZCIf8bdM5zTHOmiGEfF7T+QFzaOQNhFvoVAYcD3nyN5KgpBpyRonnc1omW3xLgvGzbXmV5XZVyfBkSaTUK4mOP/QVmG2CiiRubugFLVekDqqSSJEmOYK24D0GVZSzgH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IXsV98FgKQYIo2EHA77C0vDBhZPG7y/02tzjRDA1jc=;
 b=SwBByEg75od90Q8I2DebBCRqShLpAF6DmEKple9UJBasea/1va5tVM36vqntCatx+KD3QXlYYEoC3+KhJ7FqFq7RK3JA2ULjYRhPcxQ/fSMFHrESyvnAM5hSc5ePXv69UESSkjiNhB79BMuefkbeUFkvZoBiukJPT/q6NGgMbqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 12:13:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 12:13:57 +0000
Message-ID: <08132fd8-f5a7-48d6-9103-da5b3405199c@amd.com>
Date: Thu, 18 Jun 2026 14:13:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/amdgpu: Delete check_soft_reset() from
 amd_ip_funcs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
 <20260617191428.1784083-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617191428.1784083-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:208:237::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fa5c6f-98e8-418d-0f9d-08decd331275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: NTtJ7SRTwqD0BYQiDMpBgTQnoYP/JMaAjzZx/i7H793B0SjFRunI0PkVsqtWT/XIOuGXQ4MGO8edx8ZnMUo/hBVNxNpPCni/lOEsM1tCxYTUtIlqKyP6aDlbrmMOkok1beKdEOIUwkvwD2n2t0CTnIpn1T1oV+0HApkmA36JRj0Z1XHpXTTjAZ4b+xrbvnabzbVdA8LSJqNFwJ9ZhI49KL/Ao78YfzQaoUWZg4k+0dJA1wOjFksDe+kYx5c5VE2gSjzBiSVS1TYGnYsOMrsoESD5UomSId6/KhFtjx53WncsCWE/7x3w9SU7F17Go03I2Xgkm3i3bjfi2flnjM3dogBrRAwc27JCF2J8yZiKi/nYIP5hp4dTK3WxMgQaGF/yII/B/Vjk34gUPjRDcjaxYRUY6d4Zk8ceBWAGvIgu7QUffirMgnFqJ5iyHU1m0jOdYtHUNeh1VJrVowCZP+dH6kBU/qj11vYWeah2hDVv/j+knveMqtxck1QdyJmNZBW5N1yQAxtDDsiGyx1l6vey+rIgtqGf45gu1XYNckdE8ENlF2Xb2n6ViKxXEzxuwViGFMF63vyzas531VC1SFAqHuvhIHKKdqqYStuBYQUiPYH+PZzTt34azsiwp9IQWuVtk9leM+hoK6L3zbogGBVagdfiS52H7ZentMmwnyc8XaNprZv20lRrgZFPh46qtFp3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBmTUVqcDN6OHRzWVRxN1h3eUhFVnpUeXlSTkNnSC83d2hUdFhxQnpvdkFW?=
 =?utf-8?B?dmhNRnZGY1VqNEtRazJoaitkRytHSC84VzZONGxudk55U0tBYTVhMHQyWTc5?=
 =?utf-8?B?QVliT0UvNEZyQTBLNklubVVpQm1DNnFKL2gzcVpuUDM3aWJudXdGSmQyTHYy?=
 =?utf-8?B?b21hS0dQRVhvdmVPemZkRWFtdE5tWjg0UkdmTjAyVUFycm0rbnNVM0k5RVJQ?=
 =?utf-8?B?SktFcXg2ai9JUkl5b0JWMmNCdWh4cE1SVnZud0JwNE1DTC91cUNWdUwrei9j?=
 =?utf-8?B?dmFVbjRQUlNBYm8vTUZNVVZmM0N2QVJFTGZtbTJWcTZCaDh0MUYyMjNjQUYy?=
 =?utf-8?B?RkJZaXZwL0NpOE1EOGtMaTIvd29US1Y0c1pvWVE0R1BiU2RSck1DdjBVMUJh?=
 =?utf-8?B?WjZZWTVWWUJLbTZkRXIrL3RnVklwR1EvS3VVd1BPbjJYYmRDbHlmZUdCVDR3?=
 =?utf-8?B?eTRFa2pRa1NSS2Q3dUhEZHZGdlJSMHZFY29EU2l4L3hYMGYxMW9yQUFqdHNS?=
 =?utf-8?B?ZG9WZDNUL3NVbG0vLzR1S2VvL2xMV2xsQTczRnpVeGZxMmNYM2VwQzk1WTZC?=
 =?utf-8?B?L1J4c0tBTDB6bmI3L0h6QXQ3Q3lEOVVTaUUxTVFDTjNpeUxwckNFNTBQNUkv?=
 =?utf-8?B?QjdGNjJkd0M0cmVQYUZhRjBhRlN3bG8xYzdQY2QrVHR5NFNwcnNZbTJuM2tx?=
 =?utf-8?B?b1VGYTlNRHZ6NkxvVW1sL000d2k5N3dZQUZDR3NEckJKV1lid1J4MXFSc09E?=
 =?utf-8?B?VXJMbUtkTTh1OVEzNkZLRGRWVEZuaG9uZ2ZnY08vZWZSVFJyUldOeVNEVmpi?=
 =?utf-8?B?bWM1Mlh2MmRpQzQ2TWluUjlrbjBpcHlaZkswTUNPQVRnK2Zjd2RKMDZ6L2k5?=
 =?utf-8?B?MEw2SGZmU00rRTliMjVmTGVwNWdUZXJ1cEFFK3pJQlJ1dDBtT0lqNTRIL0tZ?=
 =?utf-8?B?Q3pwMjBzV01ybUZ5Umt5UXF0b01WQ3JWQk9ES1dmY3BkWEJQU2xrazRadUhj?=
 =?utf-8?B?UjlYVGpKemltNm9maVhlZ0w3VE94c3hyaTBQK2tPaVVPWHBEMDZteEg5eHZB?=
 =?utf-8?B?TXMxT3ljdjExN05Ra0RrN3hBZ0tYQWxlUE44L0pldUdnTWZWZExBYUdiU3Fr?=
 =?utf-8?B?L25Yd0FjV1YzWW9UWWFHZzlNa0dibjExbnMzaU1PdGVqbG9sRFNVWmIwS2pa?=
 =?utf-8?B?ZW9ranVwWDhCc0ZSRE1lM3IzRktGOGZBN0Z5S2xOVWVZN1lQbVI5RGJTcHFC?=
 =?utf-8?B?SHdRU2p4ZFNsUE5qWjdLcnRqN1pzWDN2TS9WeHhnZXZSUTY5NW5kQTBUODZk?=
 =?utf-8?B?YzdFM2d6bUxmMDBwZkQ4dTBvcVN3OWhCSnVJa1J3SkFNbDJyaEQ4akl4aGRS?=
 =?utf-8?B?bjJQVTNsTGdaVEhJd045R2FHd1BWVWFIb3Q5K3VsN1ltc3VDQTFHcnd0Y3hn?=
 =?utf-8?B?WGhZdzR4bjVNK2RxODIxMnZla1hDSFF2Z1BMWlA1aFhVOHB5OHkwa013Umla?=
 =?utf-8?B?ekNTN2dDSExmdys3akVNcThkN1kxMVY0dUY0M0tYRXpwVllOS1MvTWFTdFZ2?=
 =?utf-8?B?ZmZ3bVdDNVg4Ty9WYVg2K2psNXdoRERCWlhPOWN5aWtqeHZRektORXZpNTdQ?=
 =?utf-8?B?NjBtVlBhUWxUUDJtczV5RC9aeDI5UlZyY0FTSzFwWVNiYktBbTlheG1idDRO?=
 =?utf-8?B?Um5TZkFMU1IrQ0I3akhjbEJVc3RUelphb1pqRnR5TGFIM3hvbGZUOTBrS01y?=
 =?utf-8?B?L1Q5MzArRzFwc2I3RXBQdHJjQWt3RWZNaHhlN0I5UXM5SU9mK3NEV3NoV2s5?=
 =?utf-8?B?aVNJRGxVWXluUGpFWmVzaVJwd3kwU2JoRHV5cnJ1TkNGS0l4VFFCcW1mdjRk?=
 =?utf-8?B?V0FVdTJmbGo1OVhjOGxwdWlJb25WYjR4UFlnREFHVFB2ZkZnRkJ3Z3cwZGRa?=
 =?utf-8?B?RTgvMHRRVjFWdm1FUi9CQnhSTFk1MFJKZ3E4YnpaRTZ0dlFMaVNnakNrcldB?=
 =?utf-8?B?Qm5HenpGaEYya0xjMkxITjNBNkNuaElXR0NDcVVNZHFQTllCNVFyRTJjRWgx?=
 =?utf-8?B?YUdHNE1yMVU5bmRPdWdjTjBpMmVhTnI4eHFKRmpNd1F5V0tvUjZ3QUg0eFht?=
 =?utf-8?B?MnhZeUF2bzFFVy9yaFFwZ0ZIemtzVncxZ1dnbHpaTzF6MElDMmY1ZnJ1SG1J?=
 =?utf-8?B?TVYyc2k5dTQ5L1BteGdodXZabjRYM3BDNWE1QjY0bTZYZVNvSmFZdXdpbXly?=
 =?utf-8?B?emRscVQ2cXlTQW9xaml2Ukk0UEdYYlhwYXhRM0JQYjJieHJTSlZVSWdjSGh6?=
 =?utf-8?Q?T4pd9FtztRDK5L3cre?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fa5c6f-98e8-418d-0f9d-08decd331275
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:13:57.4036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wncY157e5tQVSi3MN/VlXEm+PIiD6AgYsqKOltmiyeuhnY6SHSeYBEwJFUCQFXSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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

On 6/17/26 21:14, Timur Kristóf wrote:
> This function is not called from anywhere anymore and
> every implementation was bogus.
> 
> Some implementations checked busy flags of the IP blocks,
> which are not really indicative of whether the block is
> hung and needs to be reset. For example the blocks
> could be busy just normally executing submissions,
> and not need to be reset.
> 
> Other implementations checked IB tests, which is actually
> more useful, but could still just indicate that an IP block
> is executing submissions normally.
> 
> It is also unnecessary because the GPU recovery code path
> already knows which ring is hung so we know exactly what
> we need to reset.
> 
> Just delete check_soft_reset() entirely.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 --------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 63 -------------------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 22 -------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 18 ------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 18 ------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        | 18 ------
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 20 ------
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 20 ------
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         | 42 -------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       |  1 -
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 --
>  drivers/gpu/drm/amd/include/amd_shared.h      |  1 -
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
>  16 files changed, 258 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index fabdbbd0abb7..0a34c08e251e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5194,30 +5194,6 @@ static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return gfx_v11_0_cp_resume(adev);
>  }
>  
> -static bool gfx_v11_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	int i, r;
> -	struct amdgpu_device *adev = ip_block->adev;
> -	struct amdgpu_ring *ring;
> -	long tmo = msecs_to_jiffies(1000);
> -
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		ring = &adev->gfx.gfx_ring[i];
> -		r = amdgpu_ring_test_ib(ring, tmo);
> -		if (r)
> -			return true;
> -	}
> -
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		r = amdgpu_ring_test_ib(ring, tmo);
> -		if (r)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
>  static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -7211,7 +7187,6 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
>  	.is_idle = gfx_v11_0_is_idle,
>  	.wait_for_idle = gfx_v11_0_wait_for_idle,
>  	.soft_reset = gfx_v11_0_soft_reset,
> -	.check_soft_reset = gfx_v11_0_check_soft_reset,
>  	.post_soft_reset = gfx_v11_0_post_soft_reset,
>  	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
>  	.set_powergating_state = gfx_v11_0_set_powergating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 130196859ff3..dd1823bd89ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4891,68 +4891,6 @@ static int gfx_v8_0_resume(struct amdgpu_ip_block *ip_block)
>  	return gfx_v8_0_hw_init(ip_block);
>  }
>  
> -static bool gfx_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
> -	u32 tmp;
> -
> -	/* GRBM_STATUS */
> -	tmp = RREG32(mmGRBM_STATUS);
> -	if (tmp & (GRBM_STATUS__PA_BUSY_MASK | GRBM_STATUS__SC_BUSY_MASK |
> -		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
> -		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__VGT_BUSY_MASK |
> -		   GRBM_STATUS__DB_BUSY_MASK | GRBM_STATUS__CB_BUSY_MASK |
> -		   GRBM_STATUS__GDS_BUSY_MASK | GRBM_STATUS__SPI_BUSY_MASK |
> -		   GRBM_STATUS__IA_BUSY_MASK | GRBM_STATUS__IA_BUSY_NO_DMA_MASK |
> -		   GRBM_STATUS__CP_BUSY_MASK | GRBM_STATUS__CP_COHERENCY_BUSY_MASK)) {
> -		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
> -						GRBM_SOFT_RESET, SOFT_RESET_CP, 1);
> -		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
> -						GRBM_SOFT_RESET, SOFT_RESET_GFX, 1);
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
> -						SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1);
> -	}
> -
> -	/* GRBM_STATUS2 */
> -	tmp = RREG32(mmGRBM_STATUS2);
> -	if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY))
> -		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
> -						GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
> -
> -	if (REG_GET_FIELD(tmp, GRBM_STATUS2, CPF_BUSY) ||
> -	    REG_GET_FIELD(tmp, GRBM_STATUS2, CPC_BUSY) ||
> -	    REG_GET_FIELD(tmp, GRBM_STATUS2, CPG_BUSY)) {
> -		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
> -						SOFT_RESET_CPF, 1);
> -		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
> -						SOFT_RESET_CPC, 1);
> -		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
> -						SOFT_RESET_CPG, 1);
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
> -						SOFT_RESET_GRBM, 1);
> -	}
> -
> -	/* SRBM_STATUS */
> -	tmp = RREG32(mmSRBM_STATUS);
> -	if (REG_GET_FIELD(tmp, SRBM_STATUS, GRBM_RQ_PENDING))
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
> -						SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1);
> -	if (REG_GET_FIELD(tmp, SRBM_STATUS, SEM_BUSY))
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
> -						SRBM_SOFT_RESET, SOFT_RESET_SEM, 1);
> -
> -	if (grbm_soft_reset || srbm_soft_reset) {
> -		adev->gfx.grbm_soft_reset = grbm_soft_reset;
> -		adev->gfx.srbm_soft_reset = srbm_soft_reset;
> -		return true;
> -	} else {
> -		adev->gfx.grbm_soft_reset = 0;
> -		adev->gfx.srbm_soft_reset = 0;
> -		return false;
> -	}
> -}
> -
>  static int gfx_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -6862,7 +6800,6 @@ static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
>  	.resume = gfx_v8_0_resume,
>  	.is_idle = gfx_v8_0_is_idle,
>  	.wait_for_idle = gfx_v8_0_wait_for_idle,
> -	.check_soft_reset = gfx_v8_0_check_soft_reset,
>  	.pre_soft_reset = gfx_v8_0_pre_soft_reset,
>  	.soft_reset = gfx_v8_0_soft_reset,
>  	.post_soft_reset = gfx_v8_0_post_soft_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 250316704dfa..f0707139a745 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -871,7 +871,6 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
>  	.resume = jpeg_v5_0_1_resume,
>  	.is_idle = jpeg_v5_0_1_is_idle,
>  	.wait_for_idle = jpeg_v5_0_1_wait_for_idle,
> -	.check_soft_reset = NULL,
>  	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
>  	.post_soft_reset = NULL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index 7a4ecea6b39a..717eaf43c9a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -690,7 +690,6 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
>  	.resume = jpeg_v5_0_2_resume,
>  	.is_idle = jpeg_v5_0_2_is_idle,
>  	.wait_for_idle = jpeg_v5_0_2_wait_for_idle,
> -	.check_soft_reset = NULL,
>  	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
>  	.post_soft_reset = NULL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 3fde9be74690..e77261a64cf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1237,27 +1237,6 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static bool sdma_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset = 0;
> -	u32 tmp = RREG32(mmSRBM_STATUS2);
> -
> -	if ((tmp & SRBM_STATUS2__SDMA_BUSY_MASK) ||
> -	    (tmp & SRBM_STATUS2__SDMA1_BUSY_MASK)) {
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK;
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
> -	}
> -
> -	if (srbm_soft_reset) {
> -		adev->sdma.srbm_soft_reset = srbm_soft_reset;
> -		return true;
> -	} else {
> -		adev->sdma.srbm_soft_reset = 0;
> -		return false;
> -	}
> -}
> -
>  static int sdma_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1552,7 +1531,6 @@ static const struct amd_ip_funcs sdma_v3_0_ip_funcs = {
>  	.resume = sdma_v3_0_resume,
>  	.is_idle = sdma_v3_0_is_idle,
>  	.wait_for_idle = sdma_v3_0_wait_for_idle,
> -	.check_soft_reset = sdma_v3_0_check_soft_reset,
>  	.pre_soft_reset = sdma_v3_0_pre_soft_reset,
>  	.post_soft_reset = sdma_v3_0_post_soft_reset,
>  	.soft_reset = sdma_v3_0_soft_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index bf09ac841a68..2a8f9fad1e34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -792,23 +792,6 @@ static int sdma_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return sdma_v6_0_start(adev);
>  }
>  
> -static bool sdma_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	struct amdgpu_ring *ring;
> -	int i, r;
> -	long tmo = msecs_to_jiffies(1000);
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		ring = &adev->sdma.instance[i].ring;
> -		r = amdgpu_ring_test_ib(ring, tmo);
> -		if (r)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
>  /**
>   * sdma_v6_0_start - setup and start the async dma engines
>   *
> @@ -1746,7 +1729,6 @@ const struct amd_ip_funcs sdma_v6_0_ip_funcs = {
>  	.is_idle = sdma_v6_0_is_idle,
>  	.wait_for_idle = sdma_v6_0_wait_for_idle,
>  	.soft_reset = sdma_v6_0_soft_reset,
> -	.check_soft_reset = sdma_v6_0_check_soft_reset,
>  	.set_clockgating_state = sdma_v6_0_set_clockgating_state,
>  	.set_powergating_state = sdma_v6_0_set_powergating_state,
>  	.get_clockgating_state = sdma_v6_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index f154b68dda70..9f232805cd76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -784,23 +784,6 @@ static int sdma_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return sdma_v7_0_start(adev);
>  }
>  
> -static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	struct amdgpu_ring *ring;
> -	int i, r;
> -	long tmo = msecs_to_jiffies(1000);
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		ring = &adev->sdma.instance[i].ring;
> -		r = amdgpu_ring_test_ib(ring, tmo);
> -		if (r)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
>  static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  				 unsigned int vmid,
>  				 struct amdgpu_fence *timedout_fence)
> @@ -1679,7 +1662,6 @@ const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
>  	.is_idle = sdma_v7_0_is_idle,
>  	.wait_for_idle = sdma_v7_0_wait_for_idle,
>  	.soft_reset = sdma_v7_0_soft_reset,
> -	.check_soft_reset = sdma_v7_0_check_soft_reset,
>  	.set_clockgating_state = sdma_v7_0_set_clockgating_state,
>  	.set_powergating_state = sdma_v7_0_set_powergating_state,
>  	.get_clockgating_state = sdma_v7_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index e1c0a4ff0e7f..d0ab1430aade 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -775,23 +775,6 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return sdma_v7_1_inst_start(adev, inst_mask);
>  }
>  
> -static bool sdma_v7_1_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	struct amdgpu_ring *ring;
> -	int i, r;
> -	long tmo = msecs_to_jiffies(1000);
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		ring = &adev->sdma.instance[i].ring;
> -		r = amdgpu_ring_test_ib(ring, tmo);
> -		if (r)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
>  static int sdma_v7_1_reset_queue(struct amdgpu_ring *ring,
>  				 unsigned int vmid,
>  				 struct amdgpu_fence *timedout_fence)
> @@ -1643,7 +1626,6 @@ const struct amd_ip_funcs sdma_v7_1_ip_funcs = {
>  	.is_idle = sdma_v7_1_is_idle,
>  	.wait_for_idle = sdma_v7_1_wait_for_idle,
>  	.soft_reset = sdma_v7_1_soft_reset,
> -	.check_soft_reset = sdma_v7_1_check_soft_reset,
>  	.set_clockgating_state = sdma_v7_1_set_clockgating_state,
>  	.set_powergating_state = sdma_v7_1_set_powergating_state,
>  	.get_clockgating_state = sdma_v7_1_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index ee8038df17e3..671f5bf18a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -390,25 +390,6 @@ static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static bool tonga_ih_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset = 0;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
> -						SOFT_RESET_IH, 1);
> -
> -	if (srbm_soft_reset) {
> -		adev->irq.srbm_soft_reset = srbm_soft_reset;
> -		return true;
> -	} else {
> -		adev->irq.srbm_soft_reset = 0;
> -		return false;
> -	}
> -}
> -
>  static int tonga_ih_pre_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	if (!ip_block->adev->irq.srbm_soft_reset)
> @@ -481,7 +462,6 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
>  	.resume = tonga_ih_resume,
>  	.is_idle = tonga_ih_is_idle,
>  	.wait_for_idle = tonga_ih_wait_for_idle,
> -	.check_soft_reset = tonga_ih_check_soft_reset,
>  	.pre_soft_reset = tonga_ih_pre_soft_reset,
>  	.soft_reset = tonga_ih_soft_reset,
>  	.post_soft_reset = tonga_ih_post_soft_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index ecd7ead7a60b..7a6b6277cadd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -1165,25 +1165,6 @@ static int uvd_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  }
>  
>  #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
> -static bool uvd_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset = 0;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (REG_GET_FIELD(tmp, SRBM_STATUS, UVD_RQ_PENDING) ||
> -	    REG_GET_FIELD(tmp, SRBM_STATUS, UVD_BUSY) ||
> -	    (RREG32(mmUVD_STATUS) & AMDGPU_UVD_STATUS_BUSY_MASK))
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_UVD, 1);
> -
> -	if (srbm_soft_reset) {
> -		adev->uvd.inst->srbm_soft_reset = srbm_soft_reset;
> -		return true;
> -	} else {
> -		adev->uvd.inst->srbm_soft_reset = 0;
> -		return false;
> -	}
> -}
>  
>  static int uvd_v6_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
> @@ -1538,7 +1519,6 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
>  	.resume = uvd_v6_0_resume,
>  	.is_idle = uvd_v6_0_is_idle,
>  	.wait_for_idle = uvd_v6_0_wait_for_idle,
> -	.check_soft_reset = uvd_v6_0_check_soft_reset,
>  	.pre_soft_reset = uvd_v6_0_pre_soft_reset,
>  	.soft_reset = uvd_v6_0_soft_reset,
>  	.post_soft_reset = uvd_v6_0_post_soft_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index c69f7d82060f..e01c4af46db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -631,47 +631,6 @@ static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  #define  AMDGPU_VCE_STATUS_BUSY_MASK (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK | \
>  				      VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK)
>  
> -static bool vce_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset = 0;
> -
> -	/* According to VCE team , we should use VCE_STATUS instead
> -	 * SRBM_STATUS.VCE_BUSY bit for busy status checking.
> -	 * GRBM_GFX_INDEX.INSTANCE_INDEX is used to specify which VCE
> -	 * instance's registers are accessed
> -	 * (0 for 1st instance, 10 for 2nd instance).
> -	 *
> -	 *VCE_STATUS
> -	 *|UENC|ACPI|AUTO ACTIVE|RB1 |RB0 |RB2 |          |FW_LOADED|JOB |
> -	 *|----+----+-----------+----+----+----+----------+---------+----|
> -	 *|bit8|bit7|    bit6   |bit5|bit4|bit3|   bit2   |  bit1   |bit0|
> -	 *
> -	 * VCE team suggest use bit 3--bit 6 for busy status check
> -	 */
> -	mutex_lock(&adev->grbm_idx_mutex);
> -	WREG32(mmGRBM_GFX_INDEX, GET_VCE_INSTANCE(0));
> -	if (RREG32(mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK) {
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
> -	}
> -	WREG32(mmGRBM_GFX_INDEX, GET_VCE_INSTANCE(1));
> -	if (RREG32(mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK) {
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
> -	}
> -	WREG32(mmGRBM_GFX_INDEX, GET_VCE_INSTANCE(0));
> -	mutex_unlock(&adev->grbm_idx_mutex);
> -
> -	if (srbm_soft_reset) {
> -		adev->vce.srbm_soft_reset = srbm_soft_reset;
> -		return true;
> -	} else {
> -		adev->vce.srbm_soft_reset = 0;
> -		return false;
> -	}
> -}
> -
>  static int vce_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -909,7 +868,6 @@ static const struct amd_ip_funcs vce_v3_0_ip_funcs = {
>  	.resume = vce_v3_0_resume,
>  	.is_idle = vce_v3_0_is_idle,
>  	.wait_for_idle = vce_v3_0_wait_for_idle,
> -	.check_soft_reset = vce_v3_0_check_soft_reset,
>  	.pre_soft_reset = vce_v3_0_pre_soft_reset,
>  	.soft_reset = vce_v3_0_soft_reset,
>  	.post_soft_reset = vce_v3_0_post_soft_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index d3db0494341e..a0638bdb9255 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1657,7 +1657,6 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
>  	.resume = vcn_v5_0_1_resume,
>  	.is_idle = vcn_v5_0_1_is_idle,
>  	.wait_for_idle = vcn_v5_0_1_wait_for_idle,
> -	.check_soft_reset = NULL,
>  	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
>  	.post_soft_reset = NULL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index bbc172db91a1..1fb1dea3f129 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -1203,7 +1203,6 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
>  	.resume = vcn_v5_0_2_resume,
>  	.is_idle = vcn_v5_0_2_is_idle,
>  	.wait_for_idle = vcn_v5_0_2_wait_for_idle,
> -	.check_soft_reset = NULL,
>  	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
>  	.post_soft_reset = NULL,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index af0af7519517..1714d9a3f677 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -329,11 +329,6 @@ static int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static bool dm_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	return false;
> -}
> -
>  static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	/* XXX todo */
> @@ -3898,7 +3893,6 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
>  	.resume = dm_resume,
>  	.is_idle = dm_is_idle,
>  	.wait_for_idle = dm_wait_for_idle,
> -	.check_soft_reset = dm_check_soft_reset,
>  	.soft_reset = dm_soft_reset,
>  	.set_clockgating_state = dm_set_clockgating_state,
>  	.set_powergating_state = dm_set_powergating_state,
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index ac2d3701e2bd..2f9e41cf3ac7 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -467,7 +467,6 @@ struct amd_ip_funcs {
>  	void (*complete)(struct amdgpu_ip_block *ip_block);
>  	bool (*is_idle)(struct amdgpu_ip_block *ip_block);
>  	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
> -	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
>  	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
>  	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
>  	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 337f9acacef0..115024b6617c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2771,7 +2771,6 @@ const struct amd_ip_funcs smu_ip_funcs = {
>  	.suspend = smu_suspend,
>  	.resume = smu_resume,
>  	.is_idle = NULL,
> -	.check_soft_reset = NULL,
>  	.wait_for_idle = NULL,
>  	.soft_reset = NULL,
>  	.set_clockgating_state = smu_set_clockgating_state,

