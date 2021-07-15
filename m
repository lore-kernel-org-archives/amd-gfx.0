Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871AC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BD26136E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BD26136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FD66E5D2;
	Thu, 15 Jul 2021 09:26:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA026E5D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 09:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHAGVQ4xuPo3+2vEtc8L/M0B9GJBtJzwkP+k9gyeOpebhUk03pzxAXPiglyJTUg8n/tDC5dyY/UK6TVnSB6bBy/UTpO9KLhKazgbCxH1ikAA3LWoHHkM6CElHHhcDMS2POomorbHPu6wi3Bzj6TNoeAOb86MM6pUauei9MYKjvUKBfDnVK6jEW1iLWPcYe26TkzGoBCqK7KUy+4wr8QbAaH70A9x6bQyRrmtNmNiRr0syy95PTVC3/POf1TTQbb4ofRb1nQVttwlqyPlaX0zqOX1jrr8pn12Edyi3XK9XQ4NMEIHXqPgaYOBj8yFj0xao+KlgUAwRVXxr1UHkpQ1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgikmDBgwaoKWlA3UMpmzGU04kenJARmbuExWUZxnpE=;
 b=PmJcK9lJkQcMZoPh/ZgL60DKXlh9fsZBt5EENBtoI515Gdnh6Hhkr08V/WT11u3eK5sqHZoit0rW/npXIU7XEXSZe3xcxLlYT4E8C3wwbASybNvNXETvSesfwgRi4V+StX2Hxdd4lidnXXnnCz7pWGvWtGVv4F/0BIJdCH3s/xJOHsZjTizr7T7CtmX4MR8DNpUmQam8B9vwqGX1KIPNK2V8cbkFK67xtkS9V52UT5hABUqDseyDdF+etGCps1r9qHEcx+ExakUifLZPsiZKgJoM4m4Am8SQ/uu0AAs2JuHkBKW+cM6Pk/ks4u6qrcoGd/Yb7zH0/Wo7LLNIvxqz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgikmDBgwaoKWlA3UMpmzGU04kenJARmbuExWUZxnpE=;
 b=N693WUG3UcOBmVAe3QncR5AFNHhqUQ9AyR8IsRZhmJunMm9Yfqx53Gopia2QnI3scCBL+4S15LhZ0DZYKlG0MdyXyzXjVhiSeW9esE8aoJ1XTczQvZeu+q/3mTZOlZUpO3zJthaAW+1VRHvsgqLx1l73gYRLiC8T2rM0GKzaeAQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 09:26:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 09:26:22 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu/ttm: replace duplicate code with
 exiting function
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210715082439.678512-1-kevin1.wang@amd.com>
 <20210715082439.678512-2-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0606dabf-3558-d263-fa88-e6d6fff47047@amd.com>
Date: Thu, 15 Jul 2021 11:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715082439.678512-2-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0028.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:36d5:a331:b1c9:384b]
 (2a02:908:1252:fb60:36d5:a331:b1c9:384b) by
 PR2P264CA0028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:26:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 012ea0f0-e01b-4342-0546-08d947729c2a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109357EE2343716C7D2982283129@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDuAhTKWR8RrGuVQV+cbz4Kf+Ku8j/0NlbjlP0L+95TScaFirR9k8Cfo2YQAm7vboF9uVgGoQh0a5juipzR9vocf44EMmMZyXla2xrcuJzkHWxHpQUwn/GVtYItclhLbCcoUXVv61t/lFRUVjwywJECGiol17MRMJpT6auqwonZvUTvhfwGdAa65Wd+J5ipNYkQ7ZsCAxU+JzHzh7FY3v9jnkMHEOHJAVRYI6+rapfF8RiO9EWjktCabquwVE3XEbv3d5ztMkaF94EjXqkQ7UaotsCKwOhcwYo5586ieeTCHin4qmKt/rRK5pC8xl486ndkzqJ1nD5cE8r0zVrmUaZXCaII9CefkUIH7NFqxyAxEXCSLdfECcGI3X/yDxqZ3rfD6rSuIq8CuGKdTHIUOMCFX0oQNbNFneUiYvo7D7ob6XBiud2t5lHqW8YoFjNRclcO+D2t+oKoB8Fdv5Cnran42xyLpTEnMmmTBf81nE8PVNSlpJXLUsFwFV8Jl84SQBYfelWHhHQXpCI2v+mcspBVHuDbjGD6Nr6zCa6OnaZ9K5AD3dCVQo/TKQZ2/dqiT2pC96wJPmzHxLMgCGZGpZ6uYEPS5a2BjJnRFzRXjjL6cacpDjVoPIP15/rgPnTBCwxVE4mBKuMLfdrm+ko3rHmuFUUaDGKbQMvrETiDYFAXg26A6JcLGy9vK8iwxHbErouo2bJUn5skREVc3DeXfp/WWoT8G2KwbyfJD23x/0TDSGAwe/es/I8oIZY8sbVZ8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(31686004)(6486002)(36756003)(83380400001)(478600001)(86362001)(31696002)(2616005)(316002)(8676002)(66556008)(66476007)(66946007)(8936002)(2906002)(6666004)(186003)(4326008)(5660300002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFUb28rT2U0LzhLajNHdkZ6T2g5dXl6RzJVZTRGNEpJY3Z3dlZHSUpNdzVv?=
 =?utf-8?B?SlVwbnpHa00vNnhmMDAyQjByak4yTyt1UFlhbStPSWdOK2RnY1dTMlJoOWJV?=
 =?utf-8?B?azJGQ2k4Tk5ZaGE4YzdkYlhBMW9WWnRSamo2eTBRM0NJVGFnRUQxREcwcGMx?=
 =?utf-8?B?RU9hZlQwRUp3emx0dEc0Q0M0T2FYTUVKK1JGMmVaQ0NNTUc1ZXpobVdvZk4r?=
 =?utf-8?B?MDJkY1YzbjBzTDFCUzJiL2w4NGR4VUQvZDU0dlZDSmRYTEFjSkRyZEdLaUF2?=
 =?utf-8?B?ek5KR2dwWmIya01EaWdVSkR0bmFkSzdvaldEV0NGcUhqYnV0eXIvc0s5ZFdt?=
 =?utf-8?B?Rk1YZVNJWlcxcm5GVUdLYmY4bzRuaFpwNEpyVWhaSk9TWVdlc1diRkw0dXFR?=
 =?utf-8?B?eEZzalNTRlNPdmZud1RiMy9MUk9udGFpYjhQWXZLOUxjYVVxK1RBeWN0OFg4?=
 =?utf-8?B?ZERQWE0ySnkrcElTOUgwY1UxNmhFQVdQNG9MekRFM3ArSk5Mc1RlbjdibmdG?=
 =?utf-8?B?bWdvZ1ViVTU1UkVGQ0ovcFdpRytVSnlsSzg2djlYUllLMFZyRjlGYWZ2cmJ1?=
 =?utf-8?B?clg5RnNEVmNpQWlZWVEwTUw0bDNjYndJYmpLb0gvVmNWbHAvdERsR2h2Skla?=
 =?utf-8?B?YU10UWd2dUpUeWY2V1FDNW9IWFdDbE9yRytqL2k0SlZmY2hLakkwS0NxeFlQ?=
 =?utf-8?B?MHJtc1cwaVN1UEZFdTRlM3psQmdyRUMwOXpOWE1CejdjeDVqbGRQdzlEWnVN?=
 =?utf-8?B?L01mUlRhM21VcUU4b1BSUjJPRkpWNjBRc2VwY2J4UENEQy9YRzZNVk5CK0xq?=
 =?utf-8?B?d2g1K3lGYUt6ZERhb0hxRXZzb2xYQ1l3WEpNQUJWc2JxVStkSWczM1hmSEJy?=
 =?utf-8?B?NnhRUUs3VjZMdlpJWU1CMWQ2MXN3RkpyK0JjRkgrVTBUWW91b251bmZmbVNY?=
 =?utf-8?B?SlJxVzBzdmdGUm51QzJsYytybTFqSld5TC9Ka2RPWktLQUR5enpkWDRpM3di?=
 =?utf-8?B?YjVlWEc5ODMvUEt3Qmt6cWtxTmZ3OHZRK1BLZVRKUFhFdXFrY3RlNTBPTlNF?=
 =?utf-8?B?ekdjL3NkNTZZTWxDTWRvblVsdHZzZjVkbFVFTmtFOWVxVmEvUjhKa3NFTFMr?=
 =?utf-8?B?TUFTWTJhTC80VDMrZFdWK1pidU9PUjRhcmZyQWRIdWdoRHA4WEtiaksxMGRL?=
 =?utf-8?B?Y1FoQ1QzL081dDNla29qdTU0djVKSStHVHpNbmFubFhhTzg3YXVNT0t1TFJj?=
 =?utf-8?B?UlVsalp6TG5qMXd4KzVhZVRvLzB6aFE0VGppK1RvbkdQb1JGdFIxTXNjRGp5?=
 =?utf-8?B?clpMeTBSU3FyUlgxRXFIUm0rNFFxTnh6NHoyUGtHcVZMN2FZckZQQ1AxbUVJ?=
 =?utf-8?B?M2ZNbFN6K2FXK0tjU2Rnd3lUSUN4U0RpQ242Q2szWjJlYWpDNm5JRXkwc0dz?=
 =?utf-8?B?RjZVY2pFUUNyeUhobnpnZzEzYUR2TkxUU0s4ai9yU2pHb1pCWjh1RGhVV2VY?=
 =?utf-8?B?Y3BObHdCWFl5RHdNVkgxczk2dFJZRTZPRFFkL2hMTmtpNGlINk9BaXpHeFVz?=
 =?utf-8?B?c1dzY210QkxqaWhudEtoOWVWWFp3RGxKSVpsSXRyZW5zNmVRN2tKSEtmOEFM?=
 =?utf-8?B?a2pzM2tlUTVCLy9WUFRZelcvdXV5Vlc2U3N5Z01yUUd1ZlUxU3VJOWZUNjJW?=
 =?utf-8?B?MUExLytHUklrVHBtODV1Qi82RDRtUzBmSVl6QmZZQ0dwOEw4Vmw1UnFJY05x?=
 =?utf-8?B?SlJMeXIxdXJrby96b1B3aTFkMFZGUkVNcDQ1VWpGdndPWmdSR21XcERWSWlG?=
 =?utf-8?B?SGJGdHRkQ2g2NXRHWmcwRXN0Ryt2OU1iVll0b1FvOUR4RmxOZk1XaGdnUlNp?=
 =?utf-8?Q?iFgFeUKCqBqxA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012ea0f0-e01b-4342-0546-08d947729c2a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:26:22.3697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct/AV6JUlsRc/mFyIk1vzI/wMa5Q13kIg1ok9r7UceMkEO1OaYK1IpHegqOYInDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, frank.min@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.07.21 um 10:24 schrieb Kevin Wang:
> using exiting function to replace duplicate code blocks in
> amdgpu_ttm_vram_write().

NAK, this should intentionally only use the MM path and not the aper path.

But you could use amdgpu_device_mm_access() here now.

Christian.

>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2aa2eb5de37a..2c98e4345ad3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2207,7 +2207,6 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
>   		return -ENXIO;
>   
>   	while (size) {
> -		unsigned long flags;
>   		uint32_t value;
>   
>   		if (*pos >= adev->gmc.mc_vram_size)
> @@ -2217,11 +2216,7 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
>   		if (r)
>   			return r;
>   
> -		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)*pos) | 0x80000000);
> -		WREG32_NO_KIQ(mmMM_INDEX_HI, *pos >> 31);
> -		WREG32_NO_KIQ(mmMM_DATA, value);
> -		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +		amdgpu_device_vram_access(adev, *pos, &value, 4, true);
>   
>   		result += 4;
>   		buf += 4;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
