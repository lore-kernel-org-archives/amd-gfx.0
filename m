Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA568CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 08:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D4110E425;
	Thu, 12 Oct 2023 08:36:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2384B10E425
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 08:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0KtBS3ROb+wp8C7fHt3ItytXG46aRrfAM/XCbgS4Z8hQrAlwYHSgkHa68puB9dRR4Kj6hKEiOBJzNRykixfao9/b0Z4hyhRZxBXgnif2CNFJnuVUHM8jI3jI/CxWtd2wM6OEZTxu8fT7wrkpMHMctpROg8QpsMgPLv+X9DnNQqHgUzTVZs3DN1Ajxn681UkL5Z9/GZh90Y7HzTTtWxPWCWEHqZyWsyp1k2Kq3IcXiWP5IxZRMcaZLuNX8DqWJZRDHfBXFfeoPU6fYzf7KxeCzHT6tbtFRZWV7oPfXIvDY0DWVLYMSF5qUWSN2iupv6EHh/3CFGT8gz2xt1UVXKOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxSghQzJskvu/PZvCJuFkrLNGAyws1y0agwanGqxrb0=;
 b=IUwMWrUKOoRA1mETosc2IVdnbOH4EPZCcTP+z9OFxBUTcTwGr8ipsKQwT50Q12nA3VI+93QsdNtni9s3Q31jjWXChfYtagEaa6GstUoOh+nJqrT+6vp+0rCMafcQXF/GEETl5bfA4xVj44PHdr3ODU6Ok+O5conn3/BNM0EB3PMEfnu5dDUpriRRDOmwmWsFBmUuSJLA1xfzR2p86OHB6p159006dFQaE3+db7XxsGbLxlQkubC2w37KI4VND5n3Jb/JVSmo8HRB54AufGk+I1WQYH2ug/6zX+fmtJrW7lmInK5KdARvJsSqnJNnJIRSiykHQLcXA/Ui+C2ZNkP5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxSghQzJskvu/PZvCJuFkrLNGAyws1y0agwanGqxrb0=;
 b=GBEKM1lmZEY656ztFEebNyw18C4okV+g3FOybZJffjcG77Svr+0KkQBUqvjXIDcuwQAhM/EUqZl50l5zFcOicIQEt1pyzz6uB0ZglZklKQrQ2bwa1a1AyZaVWN1nDdpgrBaPon84CyqPQUvk/3pS56RBttIUJ+bPf4m1fDr1adk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 08:36:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 08:36:43 +0000
Message-ID: <a78db0cf-6cc0-4ee7-82dc-ba07963be73f@amd.com>
Date: Thu, 12 Oct 2023 10:36:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: flush the correct vmid tlb for specific pasid
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231012074115.660773-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231012074115.660773-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5424722b-b31e-47f6-2b98-08dbcafe5cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFbWkzWbxNnkgPRN8Xvvd1wNNcRluEgfBiliqOTi2J+xg7n8FjVy0aAUkhhPg1BSpXe9GYiXJyeITXe+WLrfMip0B3sUuGmCIRR5YG0wjOh71s6nfoX6uzk08JUYrO1o2bEIX+sudRI5X5htC66pj6mPLRU9MtZQti7aUbeUX/arHIQMczBDyjTYG8Psqrgi0ipmiwUAqDlco+k1wn1bGTWgQUue5LPFYGLTizV2mqwRtJvz8JogYd2FQVwpy++/Cefzj4Xg4RoasL9KZIcUiDNkmSsNAnwfHS4NoD3jTFbcqRSoYDd4ix441PICpSWk6s0c8E5ER+3aboZibqFRWAI8bQtxDKd5PMFqANCmGWXh/eu8xiqN549aufwRj2/9cjxvtYgL2oTGLWUnzNTA+BkHTyWhxpSuxbVw4l2A8juw7VKK202CxI97bnOuWX2mknS1EJd8blcW57WmuRZlfm5LTlUwmT3FLxV7a1g40QdU15H5o9ye11BEcNx+y6Kwgh9kLFhUdlQxH5WW7ZS8Lt0y8OIB32GM9HwqmhG2wzMItgVEy0zrNdETyxUt2ASn9KP1LX1D3MeDjACnk3Y9aw6BYkYDKEI2ihTkUfmaB5wCc215isLM4BuCMx8nEkI57hY8SegCDxrKAelwBQy8Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(66476007)(2616005)(66574015)(83380400001)(26005)(66556008)(66946007)(316002)(8936002)(4326008)(8676002)(41300700001)(478600001)(2906002)(4744005)(6486002)(6666004)(6506007)(5660300002)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHE1UjdoMFZoaEdiTXZOK05Samt2QlZiNzNiQVZhRUlVZzFXYjhGcGhrTFBy?=
 =?utf-8?B?aEt6WDA3d3BhM01McG10OXdvT3RmWFBvdzRneG5jS0N5OUhVUTRURU02ZDc2?=
 =?utf-8?B?OG43TW45amFza01rSm1tSWE0QVMwMmVoaCt5NXdqWnNnRkttUlBrRkg0M1JH?=
 =?utf-8?B?MUNzZUJNVW1Ld1l5SWRmN1Q1NGZPSGkxaXpOeS9haWtxa2oydXdzRElGL3Zi?=
 =?utf-8?B?QWhYcVY0cXc0b01JUHlXNjVhR0w0VTQ0S2VVMHdOdmt2Zm5lS2Fvam1hZ21X?=
 =?utf-8?B?WkVrL3ppNG9VUGJkNjFRWUJ3Z2owRWIxY2E5cGYzMmtzK2wrQlhQRy9kekZm?=
 =?utf-8?B?MjQ1TkhlQUtoM3Focm5lL3hhSlBja0tjWXhkYTNOMm45Qi9yaFV2TERkMytQ?=
 =?utf-8?B?U0J4YTI0TTEveFhaOUhFUGhhU0JDWXR4ZEthUHFKSmRBajhFdVI3bFpiU24w?=
 =?utf-8?B?KzlQYkprOXdscnpyditJdERyTTNpNXEyVCt5UU9VMDFGSlhTTkpML3pSbTB3?=
 =?utf-8?B?clM4cmR3dmpFQU5YZzhtVzVTeWFGR1ZMZGZtM3V6MGtCMTVXb0xXZ1N5ZDNX?=
 =?utf-8?B?VGk1dzdJZzVSQklQZlFDS3dMOGdvQWxvOWJObFgxelkrOHR4UTRyTlByUzk4?=
 =?utf-8?B?TlNqamRYQXJuWGpUTE5xUXI0NjZLR2tJSjFxQnpYaEM1WXVUU2V3RW1CVXA0?=
 =?utf-8?B?VmJFRGFOWmVmWUlLQmFqTVFuTHA2d0h6SUhKaDZKb1NlcmtxaUlvNUgwNWVp?=
 =?utf-8?B?VTJRRXhnZDAwT3h1a0laaG5RUjJhOVArbHhuZUoydGd6RkRtd2VSdWRiRS9y?=
 =?utf-8?B?Ujh1My9FSytvOWJyMnlrV3JKRDFyaW8xN3BxeVVnNnY3bjNGOFM3cEVRZzFJ?=
 =?utf-8?B?dGRkMFpwWVFGMXpwMWwzWENkcHBFRnN0RlpYTjBMWGdHWlJ5bCtsTERjTDZC?=
 =?utf-8?B?WDREdUhNUDJ5cy9HY1BXSmxxWG91Zi80WE9wUkdjcW1EWXRnWnZYaFNXUFFP?=
 =?utf-8?B?ZXdjOWJkdzdGZGJNUlBPMTVyK3JHUmtid0hSdmphTXRrajlmaTkyR0RPanht?=
 =?utf-8?B?NzhpaTdkbXh5bU1nY3NuWWExZDZUbFIyUWdCYVBIWTI3UE0rYXFOeVVBTjQx?=
 =?utf-8?B?aCt1QS93RGZ1WTlRTmFQRm5jVWt2MDRjNldVNGZZSlNiWjNmV0pVeG0rNnRQ?=
 =?utf-8?B?ejNOTGZYaFhyb0tjQjNxeHBKbXd6cThhWW9rZ3h2dnVtaDE3eXlucDF0QjZa?=
 =?utf-8?B?NThTbU0wamdmU0FUN1dYUGRXS1VOdVVhcXVsMFppNzFHM3Q0WXBXNXJoTU9J?=
 =?utf-8?B?Sll3OEFHZVlWQXUwTEFOWFp2MGNLVEhsaE1yc1VlV1RnSm1lb0dOUTdJRkR0?=
 =?utf-8?B?VFo3TlV0WlFVZGp5VU4xK0x4aGdZT1k3dTlWcFhFME50ZWgxYnZvSnpTSjU2?=
 =?utf-8?B?WHB0U1FQUmlKeEpFc2o1dnE0YmQ5VGh2Ymo1TGhnUHhCcnY3YnRqQUlIRnB0?=
 =?utf-8?B?a2R1UDIybVR0dDVGMVhzRHh0bWJoZkt0V3lDVlBkOXR1UG1OT0VSRXMwdm9r?=
 =?utf-8?B?VlB3Z0t5a1V6K2t1c1lVR3lHVVl1Lzc3N2gzd3FjSU1pSGNIR0VkM1dzWjlo?=
 =?utf-8?B?VXd2RlVXTE0wOWNWOENGeS9vaXdUZkREcVB5c1Fib1hxM0xhYXc4ZTY1d1ph?=
 =?utf-8?B?bjZHSk80WVNQOENmQ0ZocVdKTGlUUXJockUwaEtMbUcvQ2FrVVQwcE16L2ZN?=
 =?utf-8?B?TjRnNlg4TkNWZnY4Y3NEOS92ZHlTNlRoNTZlNzdLWDZkbkxuOUVBb2VqSDZi?=
 =?utf-8?B?K0J6cFhOSHpnOVlhTzRlam5KY2d5STJ5MHo3WENNMUFBVnQzMzZCeHliSDVa?=
 =?utf-8?B?MSt3SEZrd3V5YWI1V240K3oxTHYrUkVYRkZHWW5FdHVwVWoweXFnQ0JsOE90?=
 =?utf-8?B?K0VvUmdlVU9Yc3NlaUdIZWh6L2cwaHNrcm1vSml2NEtMZDUwOUVONkFvUXZO?=
 =?utf-8?B?TWpncWNTeTJocTdlN25UTndzWFhyZjJDc3kwOGRtbGFzaG80MW1RajQ4N284?=
 =?utf-8?B?R01GSW9PQ3lNcjNNTG9RQXFRbkxpNVRFb0h0Z2VQKzFpNTFoRXdjN3p3MGxr?=
 =?utf-8?Q?7ANQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5424722b-b31e-47f6-2b98-08dbcafe5cbb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:36:43.1228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NNU11Icro9Q1ipetWJYMDo5pzTBlIkPs2zSNgJukZlXtsLKCxvG+82NRo9iIEbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.10.23 um 09:41 schrieb Yifan Zhang:
> flush the correct vmid tlb for specific pasid on gmc 11.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index f4bb3886d1bc..19eaada35ede 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -314,7 +314,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   
>   		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
>   							      &queried);
> -		if (!valid || queried == pasid)
> +		if (!valid || queried != pasid)
>   			continue;
>   
>   		if (all_hub) {

