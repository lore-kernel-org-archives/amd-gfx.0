Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC37C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA8710E6F3;
	Tue,  4 Apr 2023 16:13:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861C810E6F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Y1WTz4Ogo6WF1arstnzDBxxPwG/7GzCKjEgLRkLalGMjdkAaX4ToAg60EpkUhRc7W7z6O9zZfR2aN3Lr5rGob2wu8Pts4FcWKElwpPLboTDvj8o0b8h+FW3gDKJUxjk2rCEVM6xUkPw/LM88sIeOe33SQe63ctH1jgtL1T86XQlaCDn336aRTiCuretrjoFAdD2uqukRdCLw00/eDCzMInkQE58ztgryf6X6VBEQ7BwPypGUYBqtfWhuaDZE+x9ZkaRKFNTWJbNlK0wYg8V34MAoNliZfR/OZsD+WpRVSdO5xGrjN1m/N9kSWDPPzqPGl+HZrcUhZLivZG3j9DGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulSJv76Nru9NBqHxzjWlc5vaoMrG6fpkcp9EfkNJfYU=;
 b=GWbDjZDDKfm1fNuzYm3hWO4bnf9wElPtuM46H94F/RQIpWr8lVyx/NHgJ/konFet9LuzhGEBL4c9S6wKuQniPQ6yVjZnLDy92UdphT/U0lEQT2TzH3eKLj1UhmmNMU2vHucNm/VFVhBtnp9JKnvLhhoZukOgmXqM6hApD884Xz4jmkvma0w3XjAFFb7hwf9Mj/lyZA9MHFmduk8CqrxgHE/JxMzHaNBDqxasifZWqHd1fjjyrq/SLcU5RFA3vQRFlku1u9emdoLh1SBETky4/mErzRSYPZFA3BDZM3m/IVV4ixTwnjHtQp9mOUjAjcAMrdNGWUfvuSeeeqFuChSm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulSJv76Nru9NBqHxzjWlc5vaoMrG6fpkcp9EfkNJfYU=;
 b=k3/Z5InfjlO8ytxuQXtauPn3d6Ultb72jetg1G3YipOLTokts/ja+dJSkoGVMwhcNZkurpU+Xmi/NsqkI0ubBpeeqtbaQnyj8s1dOnhw28ZoZG5dbZm/UbEbHXvysKpRtuPEuMesk6Kxfcn98wnKZqLoiwMXuFPukOIKEUO/hfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Tue, 4 Apr
 2023 16:13:11 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:13:10 +0000
Message-ID: <9bc5f6fd-f1be-12bd-15ca-5d44e3a8cb99@amd.com>
Date: Tue, 4 Apr 2023 12:13:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-2-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 01/16] drm/amdgpu: rename num_doorbells
In-Reply-To: <20230329154753.1261-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::13) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9edf7f-657e-4f3b-cf33-08db35277c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFhuuzwjJ5KA3VMCXHO5yfiZuCPH1c2VOJcs7ZrcdyycPkY1hIMMMHiEzPLXBL/O9DpkHzIh9o+T7tOQ93+292DDFpxTf2dLx/pGRi4eNytI5y80dgdkan2r4txBL9lCBy/JgMmjyKl/GzAVgf233kBfxpUjl5Rc/syeciNDWCE5A0nSzizqYM+e2VPKiCmLu0WTimJRItPbdgxzuRsehyrkucZ0q65wIbGfnPG/sJjs7z0b/QjblzrSrUdVTjsi+/tkSmeveSa5/hLOj+GDDPBuugFbh+adNfBcTmPzl32KH9QrAbZqmMvIE27rCdcJYflEzPkyrakQwhSs1Hi0ABqx+cVasBSoOwgiPhq2P7hAV7tswWcGR3nthN38hmDhZB6vviJmqUjKgLsZGYHVZO3mRpxYC8zPQJDH8lryPes46hRsmqlaCvY+IH3FmFgtF+xxhQcOJ3YmwpwL1hdsToHGDnC/L+8UTAxjLYTzc2SnKJHMxYpQDEhTV6LoLz1lehWtOXT25ABZ6IZ2I4vwDaw8Uq5ftKX84e3UCb1GYyh25MfebG3Ss9907s+1XimR8hzTa+OuhJQT50TqoiVWCBafmMIDoQzwCUmmHpnvp5NVvfMGNcfaB0yDBGxwbOzxPcveJyaEG8vM5emfs2kZlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(31686004)(66946007)(6486002)(4326008)(66556008)(54906003)(8676002)(66476007)(41300700001)(316002)(36756003)(86362001)(31696002)(53546011)(6512007)(6506007)(6666004)(2616005)(83380400001)(55236004)(478600001)(8936002)(2906002)(44832011)(5660300002)(186003)(38100700002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE85QkkyRkpEbmYwZmhVQW9tU2pQK05tUkVpLytxT2ZmY1l2OTJlbUxBSlly?=
 =?utf-8?B?TFZIcGZ5bVhmRjFJMmU4aW1Ia2xjbWxvVjBaS1dFQlhBc2pHSVM3eXFFaFNL?=
 =?utf-8?B?SmQySmZtNkJCYk9YZlhkaXNhT3I3aHAvdmdubytmU3AweDRFeW41Kzh0OVlv?=
 =?utf-8?B?N2VkRzJqRnUrYjQ4eWJhaGFCM2tCbUcrNk9SVjV0Qm1lVnREUFZYK2liVVRw?=
 =?utf-8?B?T05NdzI5OEZRR1MxSmdITmJQRTV5QnowY0ZEMW5oZERCakpEd2t1QnhzTWRo?=
 =?utf-8?B?QytIR3FrZ1k0ektNcHRRR2owMEYwNXprVVI1dDJXR1loaGJpL1h0MFZwWU9S?=
 =?utf-8?B?Vyt6NW1HZXVkNmdvNlpqMEpyQjFyUVFaVmFVZzlBa29JRk5WZnJ3RGtyK2l3?=
 =?utf-8?B?d2EzUGtTMEtVR3RRNEtzaWFZdEwxN0hSZXg4eCtoMVlzK0RiaHRNSWtLanVO?=
 =?utf-8?B?aEJuKzY0a3VyVytvdzgzREVReEM1VlNtRnA5b3ljZW9aajRyN0prNC9WaEYy?=
 =?utf-8?B?RTFuQ1hHY3JCWmI3bWRlWVY1OFdxSHI0SzNpVkd4YzloY1U2dURYUW5QcW9V?=
 =?utf-8?B?WkhjV3EvQ29GN2hscktxQk9sdTIzS3JFb2hmakp2QlRsY3pCMFc0L1VqWWJx?=
 =?utf-8?B?TEhlbWlIL25tUGtmYjVPM3JjbkwzSkNDc3JUd1c3aXdWTGVLekp6dnhTQnFH?=
 =?utf-8?B?Q3Z6cDRMc0lkeHNnNDg4dVQ2V3VBNUxlZWZ2MWc0WU9WZE5haFR4UWhHOHpN?=
 =?utf-8?B?ZUNPSmUyS2dUcWU1bU9EV1lHZHBsU2J4OWJiYkdzcEp0YjdXUnA5VXVhc2Qy?=
 =?utf-8?B?NE9DQ281VGNqV0h3S1pLdDhpR0NiSDFRMDFSUWVSUUlmZDBadFF2UXhRZ3E2?=
 =?utf-8?B?bHZ4SVU1OW9MUkdQRkduaFkydy9tcnFEU0F2ZmpOV3oyN1RNWTdxN1FZcEtl?=
 =?utf-8?B?UmtXb3kxZG9MVEttUFdLeVZ5VTAzNno2ODI0Q0V1eU5adytCWEVVemd0QS9L?=
 =?utf-8?B?UEprZUZ2WXJWYjRUUFJ0K0N5cFJheGNjNEx1ZUhNaXY2akVkRzE5MTlIdXZz?=
 =?utf-8?B?REtvZXF4dlU5V3JJdGd0MkxMaXYzQ0dCR3lZNGhxVkhzblVsUnF1VlVyNVNQ?=
 =?utf-8?B?Tm1yUnkvTUxHRlhXRjcrYjVrd0RoTkgrK0NPMjE4KzgzZEdZeDcrcHZIQjZr?=
 =?utf-8?B?WjdyNk4wbFkwamRkSitKNDhEU2lrNmN0bi93VTNlY0hQbmxZQTBFZjBvY2Zw?=
 =?utf-8?B?OHVqOEEyWXBrTW52WlpIdVlsN3lhUGU4Y1FGZ3g4OHFsRmRtZjBFYjhtUW5F?=
 =?utf-8?B?K1JveVZ3clNEL3RZelhtNk4weDIzSDFtR0pJeTJjcEVxLzBwTFVDNVc4V3M3?=
 =?utf-8?B?aHQ4MXBkeGsrZjRrR2kvaUV1STVvYjJZZUtDb29BRSt1YkRUUE9yaExwQWw1?=
 =?utf-8?B?c3cvc1pWdFJFWXF3aExUN0d4QTFVQVEveFhMME01a29OQkhpMkF6NjFhVzFa?=
 =?utf-8?B?VE1zUHdBRzBtcGEyWW5NZVJBOGo2aVVlYVlMa3o0OFk3SDR6ZXo1ejJTQkU3?=
 =?utf-8?B?bzMyM1I0dlhhOGpNeXRCS3ZHL2hicmV4aXVDTjVYbldlaVhpYU1aSG9qVjRm?=
 =?utf-8?B?b1BpR2lzWlkyUVEvWXdHMWdlRUlVYWlMN1Z1VkFpWUNyaW9DYkQ3anNXNU0v?=
 =?utf-8?B?TEtWWDJXT05hMlE2c1hFMDJVMUZ4OWhXUUVsWU9Qa3BEZFYrRjNlWnlIMVlG?=
 =?utf-8?B?aDFOMWdzcWNpajg0amZIMW13cWw0dGp4Sktha3dsbUY2dUIzRmZVM203OGNO?=
 =?utf-8?B?WS9HNm5MdWhUbTNROUNaWTB3aWVIMndqUDJLaXdhNk8zanRkLzlZWFlZdVBN?=
 =?utf-8?B?SkZRWlU5YUJ4VldFWndhZ3lIeFJlYjExanExbFc3MWFEVzJFd3htTW5GWUR2?=
 =?utf-8?B?ZHNkajh1dldrWWlDeXFrZC9vcklGM042K1hYTkVtRE9xK2lGK2RTQ2c0QVZh?=
 =?utf-8?B?eXJZMTdGUEJrMHdHdWo2QWtBZFc4OWdUYnNaUWlnK3lEZEhRNkFNYkJHZFpE?=
 =?utf-8?B?anIyVHNSc0p4ZFd3b3djaVlJRHdZUnhISGtGS1l2enExTFI4cVp6ZjNIcGVP?=
 =?utf-8?Q?szEfamJN9vuRu3+hdKU6GPXkV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9edf7f-657e-4f3b-cf33-08db35277c15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:13:10.6592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAuly80qsecL2dJUsrcaF5NYAXFmAMMBEc/y2LwZlSGbCB0/3KbesFj5jUfCGxYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 11:47, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> Rename doorbell.num_doorbells to doorbell.num_kernel_doorbells to
> make it more readable.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---

Is there any reason you break up the Cc list between the Cc tags in the commit message,
and the SMTP CC list?

Just do either/or, but it is preferable to add all Cc into the Cc tags of the commit
message, and then let git-send-email fill in the SMTP CC list, and just using MLs
in the --to= argument. (Although, one can include those too in the Cc list.)

Regards,
Luben

>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 +++-
>  3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f99d4873bf22..0385f7f69278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -96,7 +96,7 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>  					 size_t *start_offset)
>  {
>  	/*
> -	 * The first num_doorbells are used by amdgpu.
> +	 * The first num_kernel_doorbells are used by amdgpu.
>  	 * amdkfd takes whatever's left in the aperture.
>  	 */
>  	if (adev->enable_mes) {
> @@ -109,11 +109,11 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>  		*aperture_base = adev->doorbell.base;
>  		*aperture_size = 0;
>  		*start_offset = 0;
> -	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
> +	} else if (adev->doorbell.size > adev->doorbell.num_kernel_doorbells *
>  						sizeof(u32)) {
>  		*aperture_base = adev->doorbell.base;
>  		*aperture_size = adev->doorbell.size;
> -		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
> +		*start_offset = adev->doorbell.num_kernel_doorbells * sizeof(u32);
>  	} else {
>  		*aperture_base = 0;
>  		*aperture_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index afe6af9c0138..57ee1c4a81e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -593,7 +593,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		return readl(adev->doorbell.ptr + index);
>  	} else {
>  		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -616,7 +616,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		writel(v, adev->doorbell.ptr + index);
>  	} else {
>  		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -637,7 +637,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>  	} else {
>  		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -660,7 +660,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>  	} else {
>  		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -1034,7 +1034,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>  	if (adev->asic_type < CHIP_BONAIRE) {
>  		adev->doorbell.base = 0;
>  		adev->doorbell.size = 0;
> -		adev->doorbell.num_doorbells = 0;
> +		adev->doorbell.num_kernel_doorbells = 0;
>  		adev->doorbell.ptr = NULL;
>  		return 0;
>  	}
> @@ -1049,27 +1049,27 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>  	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>  
>  	if (adev->enable_mes) {
> -		adev->doorbell.num_doorbells =
> +		adev->doorbell.num_kernel_doorbells =
>  			adev->doorbell.size / sizeof(u32);
>  	} else {
> -		adev->doorbell.num_doorbells =
> +		adev->doorbell.num_kernel_doorbells =
>  			min_t(u32, adev->doorbell.size / sizeof(u32),
>  			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_doorbells == 0)
> +		if (adev->doorbell.num_kernel_doorbells == 0)
>  			return -EINVAL;
>  
>  		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>  		 * paging queue doorbell use the second page. The
>  		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>  		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_doorbells should + 1 page (0x400 in dword)
> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>  		 */
>  		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_doorbells += 0x400;
> +			adev->doorbell.num_kernel_doorbells += 0x400;
>  	}
>  
>  	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_doorbells *
> +				     adev->doorbell.num_kernel_doorbells *
>  				     sizeof(u32));
>  	if (adev->doorbell.ptr == NULL)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 7199b6b0be81..12263986f889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -29,7 +29,9 @@ struct amdgpu_doorbell {
>  	resource_size_t		base;
>  	resource_size_t		size;
>  	u32 __iomem		*ptr;
> -	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
> +
> +	/* Number of doorbells reserved for amdgpu kernel driver */
> +	u32 num_kernel_doorbells;
>  };
>  
>  /* Reserved doorbells for amdgpu (including multimedia).

