Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D872CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE0C10EB7E;
	Fri, 10 Oct 2025 08:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ceO6JUDr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9136F10EB7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOKsD04d5cc/dEEfEmVTA1ZezFskAN+DUg9w1owYL6Y7bdSstUCLG/j3LQM0gdCiuW6z3iWPLxvuW+rp3Cfm6wdszJOzLvXOCyPukaM4Ebwoq2jBFKo8NnO9cqX76X64m1Hof03mCkl+hmOYREB5uEevQsDZeUlCOJZRycxmgKygeriLIY+8tqv5BXZSinCH7Akh8GHfiqrQd4juV6c7lKTw7ntklN0FYOOeBYgK8QSZiWtDoWSWF4mpFqZib5t/YMQR1JLf14Iik5iPO9z6kFk3aT9/FwDgP9E5C8tYYKUJafPZiEr38wIfPoWAQFpnp5un3JbyGWft6jacGZ2p8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WydbxjcS2IinZYPK4RV37gcU1Nc0JynJ0tycxCuQQ58=;
 b=i4X+uCRjDr5ng9PUCwbafBS/JY2JhgAs5hgpwXtcrVVpoUZuLU/uZMJ3c9gUoMKxD42IGHkU3Gu9QJCqO7Y07ZPUpM4w4d5oyuWwjnSjYIasabX2qBdYhU+YdYWerMcR/VRlMGxVy3nTedmvfP+0ynQbQrouvK0BtVzKkE00aJ6NfhQxbmG7QSPAvN634GTjr2vNoACo0aQuL4p0pmC5URhB8hfHrAaOBoi3XLSvl8IL2FhAsYMGv96Kjn4PXvyR1C3Vddudr4HpymFVgrMvMzNbSSY5s2qshBluV2T5gVrXtr1I2pskJ/tibGZ4Phv83FzYReJEYrfW1N142t2HTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WydbxjcS2IinZYPK4RV37gcU1Nc0JynJ0tycxCuQQ58=;
 b=ceO6JUDro0o+1lnQ59dBdwkuMwA66FHHy3EbS1XgEnpbIQG/rbweWb+g7qDNiJwa7nhRYFBByXuFQy8B6s5noKD4zz7ILoTNxCscG7MrIxN1W0I0WHmEa1isFrrLN1Rg7ZObeRUa89plhK97vibgvyeoQ5IwR7zJQSVb/aY2R/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:29:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 08:29:24 +0000
Message-ID: <634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com>
Date: Fri, 10 Oct 2025 10:29:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdgpu/userqueue: validate userptrs for userqueues
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251009131849.3167145-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251009131849.3167145-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: c622ff0e-cc05-4123-f7b2-08de07d71e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2tNWWt3TVBmT2NWc05ROXB6T1BRbW52S0JSRDQwb0VrVGlTWk56S0p6T0gv?=
 =?utf-8?B?WHI1eDgzZkJ0dTIrQ0pndmhHN3FnYUVQZTBCc0oxVDFUcjVjKzR0NVkyeUlI?=
 =?utf-8?B?T0JvK1hPZ1p6ZXE5Ukdsbm5Gb0JjczBoS2ZiYyszcjV5VkhHOWl1cm9vK2dZ?=
 =?utf-8?B?ZUF0N1d4bm1kTXlSVURrdjhTYllTZ05IYk1UeUZFeitlUWR6K3k1dDA0QnM4?=
 =?utf-8?B?dXJ5Wk85VVNPMGowVk1Ia2o0N3d0ZHEzc2dCNHZxaDFFcWpCNVRvQnduL29u?=
 =?utf-8?B?QUdoYmJ6MGlmQUV3NWdhWnJIUnVpSHprbG9Vc2duUkxhTFhVbDhDdkwyQzV1?=
 =?utf-8?B?ZVdXaVo2b0hVV3hFaWpCRTM3M1hMMExNOTBkemZxL2VvSExGY0tORW1UTHVU?=
 =?utf-8?B?dUROWVZXdHBXSUZRS05KZERkVXcxRjExcE9IbEphOStxV0VUb09yMlg1MzhD?=
 =?utf-8?B?MkIzdnI2SWpNQ2VtUnZNSVJobXVXU0RxR1UrUE9RelFMUTFVSWJVdkc0L1dp?=
 =?utf-8?B?THlwc1JpWHM2UnlxNk1ZU21qN055UEJsNTRSaEsrakNiUzQzTGxwNGdMK01a?=
 =?utf-8?B?QzhDQnl3aUwyMGI5SW8wMjFaS3F4Uy9Pdlc4eW0xWi9JTHRIRy9LMUVjZEdT?=
 =?utf-8?B?U1p4NUlHZDB2OUh6ZUlTVTJnV3dpYU1jK3BaQzVsZUoxbWtlVFB1YkhKbm9v?=
 =?utf-8?B?czIzbm9oNFRJNU5ZMFN5NVpqeEpkeXlOQnAxdlVQR2xsdXBSRlZwTHNDc01n?=
 =?utf-8?B?b3ZFczlKWVlWWTc4WWxwdnM4YmJYUnh0OG44d3VBcGw2aUhvSXpDTWpyeXJZ?=
 =?utf-8?B?NURQV1dDZUlrTkFoK3JObjEwWm0xWWJjL3BES2NMN1Y1ekxFRDB1SWR6TXdZ?=
 =?utf-8?B?UDE1cEFBaWc5Y2R1aUhYdzNnaGhsSTA3Um5mdDRvamR0RDBPMDBtT3pWMzhz?=
 =?utf-8?B?REhYRnkzVjhPMldoTnlVaW1CaGs1a0pwMVF4NUpVZTIyZE1OTkJTZUdZQ3pD?=
 =?utf-8?B?bGlINW4vRFYvSU1KUU5wSk9TcGJSTW11ZHBPRTkwQXcvTWc1M2Zidy9ieitq?=
 =?utf-8?B?RVR0RzhXcFZwbUtLQ25hQjZqL1ZVdkhPbXcyQ2d2cnZPSEpKSzF2U3g2dUNU?=
 =?utf-8?B?dkQ4bk1pbloyT0pvZmk5aG5LaHA3VWNFQm96NFIrbGVQL1pNbkRVb28xYVl3?=
 =?utf-8?B?d0orNFJJdFlLQjhQdWJUYnNGeUp2eVp5NXNHUUhYeFZhbjNDL1lxRlBPMjRI?=
 =?utf-8?B?VjhKczlPSGluT3l0cnV2cmc5aHpmWkEveUZNRzIvUnRxT3l4dVRvWWdsMFhO?=
 =?utf-8?B?N0JsM3NSMi94RHhnZUhHbnBpd09tR2UyamxvQ1VwWmpnSkJvVEZET2JWYXll?=
 =?utf-8?B?VG9vTnZiZFd0bFNNU2NwNU9CcmpUNElWRVUwSmtqWVRtY0FiVXQ2ZFpOVlBk?=
 =?utf-8?B?M0I2NjBEZENKc2JjWmVRMFo3OWRBWGZHWlp5Z0F4Y1NHclRWeE80MXpmRDhj?=
 =?utf-8?B?L3NEZXBJaEpUdkdsWWRGY09SenYya1dpNTRLbGtqOXpCWjgyOVA0QVNNS1pr?=
 =?utf-8?B?N2RUUkdFV3JQbnc1cjBTNVNDUnF5dkIvTlRQWCs0c0tVU3VwWmZYTDUzeXll?=
 =?utf-8?B?QmJ2c2ovNTRUUXJzcGo1S1AzSTY0bHdnYXZMQVVWOStvRGkyVnFzeHBXNHFz?=
 =?utf-8?B?bm14bkI1cDhoUDlUdnFvVzZzREtoS1BxODR3dkd2cjdoOHVNSmlpT0pCUVNk?=
 =?utf-8?B?Sk1Sb202M1lFSnJkdE5nM3ZLakdVWHQ5OGtBUEcvbUUrRFN6NXF6cUdRTHlT?=
 =?utf-8?B?a05VVE14K0E4cFpsZWtjcEhOSHhBVVlFck9jQW9rakp5aXIraEFMWDB6NjdE?=
 =?utf-8?B?MGlUZEtBVzBka0NMYy9OZGNUMHJVOG9mbVFoVW9sb2xIbW92ekMrTlFxbUF1?=
 =?utf-8?Q?2jFHaxXt32jAsmJBRfm8MOhKzLrpnXn6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3I2MXNySm1Cb1NGWlNJZmRyQVJNMlpFOTBKSk1ucDFqU1RHRUFMRjh0SWlE?=
 =?utf-8?B?NmgvNmI0OFdHSzFzUzBLZ0NxV1ZuRCtLQWdDNUpaU0hIM2I5dis3a21PQ0lp?=
 =?utf-8?B?dytjU2VNcHJKNXZabkgvZkZkQS9qNlRCdXJKYk5nc1FqaUNNci9jVzA2OUky?=
 =?utf-8?B?NDdBZnU0UGxwNVVNNmcwdUVrSklnVXVwcEdUTGc2LzVRd2gydkZGMGFYM09K?=
 =?utf-8?B?MW44N3JheERIMUNJVjNQV0tTUzlBbXM4NU53eEp1RFhaNUVtSFpDMVJvcStj?=
 =?utf-8?B?WU5vcWZjUitqUHZHMVJBenk1MENkWXJXaUM3ZTVieFpPOEptbWk0SjhBbVNE?=
 =?utf-8?B?YUtKU2RiT2l6Sjdwa0hZZXN1a2E4RnN6YVQ0dDZWQ0JFM3JrRnhkczJsL1Vi?=
 =?utf-8?B?NlhqbWZZZ2lpU1U5U1NNUWtUYjQ1RkFMejRRazh2eWFKNk54dUpmR2ZYR2c2?=
 =?utf-8?B?TFZQZUpOUUh5Q1YwRG1aMHVEU1RiNkV5bngrZjhDY0VkME5qVXJJTHdjUGRF?=
 =?utf-8?B?TkwvT09BU29EcnZONUpPSi9TMy9UQXFZT3MxWVdjRDZSYXoxczduc2NwOGp0?=
 =?utf-8?B?L0h5WWtwUmRxbjJjTWxSbWFOeVZwa2g3QXVMUS8zYjgyS25lRUNGUFdWUGdp?=
 =?utf-8?B?OGpFaEZvbCtpaFV6L092a2p3VU9OcWh2bTZteWlSTHVVR0dGNEIxaEhBWFly?=
 =?utf-8?B?QlQ0Vis5NGllaVBaMWw1TjV5Z0Iwa1h6WWgrcFBOT2FXNWY4U2FhZ3EzSnRV?=
 =?utf-8?B?eHlGbTNBeTJpVmw4bTFUTndNVHA1bS9FTnZjeUVkVzI4YmhWcXY4N1hJUk94?=
 =?utf-8?B?Mm55YkRGK1NXVzJveWJydDJKeG1UNUlDY0s3d20ydUMxZGZ2akwzeFRJTFZi?=
 =?utf-8?B?akdGZlU5RjcyZTh4NjNWaDM4b1VZR3l5VmE5Z2IydDhLakYreXRqbUVhTGtx?=
 =?utf-8?B?Q05zUFBlYjZEU3lUS1hnOVpTQ1pnNVp0NVZ4RjFyV0FUU2R5T0k0NGxVZm1p?=
 =?utf-8?B?ejFxK2pFU21sNHdZcWhHSzRObDc5SUhMMFhGQ3V0UCs2Z0ZaZmxHb3F4T0hG?=
 =?utf-8?B?UzVIL3Qza2dZRGRKMll1WGo5aVF4djFkZkFNTXByTEVQWUNPUzBKYWNrNk0w?=
 =?utf-8?B?cVI2aDZKdFpqWWtFcjZxTWUvWDZqR1d0bmgwa2Y5dWFnV21UUVhDLzRQN2RJ?=
 =?utf-8?B?T05yZlBXdTh1ZCtLMjB5aTBFVVlNTXZSODBkanNpSWovN0FNM3NORTFoTVNG?=
 =?utf-8?B?Y2NSYU1VYk8vM0dpTDRFSFFZNzd2WkEzQmhRYlNWdXRWcG5Za25vZ1VxV25h?=
 =?utf-8?B?SU5Kdm5JdXJCZWFKekRUdDBqWVpmSXZ6WTZKNGJXSDl5aURSckRMbmx4ck9K?=
 =?utf-8?B?ZkxyNG5GTGkzQk9IalBWNTJ2UEhyRjdTZk9yOUZmTVdjSU4yR21wcHNHVGls?=
 =?utf-8?B?bHFZWkwxQ2IzV1FIQisxRGNrK1p4T3lJaklONUI5cEdpYVFkNS9zOUJiUEZW?=
 =?utf-8?B?QmRQVUQ4YU01cTJhMHBVYU1ZWElVNmcwNWRUcC90QjhmRXV2MDAxZzFVQ1ly?=
 =?utf-8?B?LzF4NnBKaU9zWEppTEd4R1ZyZGphQlpBVFp1elk5cDdESVU1d3Q5YXNkWTBR?=
 =?utf-8?B?S3Jrb3VlRGlyenU2c2JzMU5CSDRXdUh1ZU83NXExRVczd3ZoTDNZUXJtcS91?=
 =?utf-8?B?cktlcFJEUDVzTzBGdk9qVi8yanJhRWJrYjVxQlBqMDNIUFhiWWUxamdJbnNn?=
 =?utf-8?B?UU51Vm03VjFNY042RXJmWTZwdGhKb2k5cEtjbTNRU1NsbFBJdE83T1FpMENQ?=
 =?utf-8?B?SmJQVERGcVVUeWVBNkcwSVh0Uk9POEZNK01QNWpSbU9SRXcvUlZ3MVN6clF4?=
 =?utf-8?B?bE9PUzROczc2WFdNTy9SUmI2N0JoWWFUYlp2bWUvQnUwUDcyRDVuSUJtczlm?=
 =?utf-8?B?MDltUTJaTlRjRXB6Q3BxMjMreDRFV0hBOFh6UnBjcm5kYmRQUVZwUzJNUXd0?=
 =?utf-8?B?dm83emVpVHdyM0JHZHd3M1N4eitobFdIUXI4K0pPM0VGUlY5TWpWS2R5eTVp?=
 =?utf-8?B?aXU1alF0R1QrcjM4R3RyRkNQUjFyWXZVbVAydXkyOWU2QndCWlozVW84V3RY?=
 =?utf-8?Q?rmWDbaCDyfi4ob9DCkBI5R0JZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c622ff0e-cc05-4123-f7b2-08de07d71e1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:29:23.9012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDIb8UlgUFImmC5Mzuncy90ZFWRUR1etvq0GbFtUsmONu50akX2lc8MWoBXdwWhw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

On 09.10.25 15:18, Sunil Khatri wrote:
> userptrs could be changed by the user at any time and
> hence while locking all the bos before GPU start processing
> validate all the userptr bos.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 87 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8dc12064da49..c7737201ec23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,10 +25,12 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
> +#include <drm/ttm/ttm_tt.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> @@ -761,9 +763,18 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
>  	struct drm_exec exec;
> +	struct xarray xa;
> +	struct amdgpu_userq_hmm_range *userq_range;
> +	bool invalidated = false, new_addition = false;
> +	unsigned long key = 0, tmp_key;
>  	int ret;
> +	struct ttm_operation_ctx ctx = { true, false };

Please sort that by reverse xmas tree order.

> +
> +	xa_init(&xa);
>  
> +retry_lock:
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> @@ -794,6 +805,73 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  	if (ret)
>  		goto unlock_all;
>  
> +	if (invalidated) {
> +		xa_for_each(&xa, tmp_key, userq_range) {
> +			bo = userq_range->bo;
> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +			if (ret)
> +				goto unlock_all;
> +
> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, userq_range->range);
> +		}
> +		invalidated = false;
> +	}
> +
> +	key = 0;
> +	/* Validate User Ptr BOs */
> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +		bo = bo_va->base.bo;
> +
> +		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
> +			continue;
> +
> +		userq_range = xa_load(&xa, key);
> +		if (userq_range && userq_range->bo != bo) {
> +			amdgpu_bo_unref(&userq_range->bo);
> +			xa_erase(&xa, key);
> +			amdgpu_hmm_range_free(userq_range->range);
> +			kvfree(userq_range);
> +			userq_range = NULL;
> +		}
> +
> +		if (!userq_range) {
> +			userq_range = kvmalloc(sizeof(*userq_range), GFP_KERNEL);
> +			if (!userq_range) {
> +				ret = -ENOMEM;
> +				goto unlock_all;
> +			}
> +
> +			userq_range->range = amdgpu_hmm_range_alloc();
> +			if (!userq_range->range) {
> +				ret = -ENOMEM;
> +				goto unlock_all;
> +			}

It would be better if we embed the hmm_range structure into the userq_range.

A structure as small as userq_range is really inefficient to allocate.

And BTW don't call the structure amdgpu_userq_hmm_range, I would like to use that in the CS IOCTL as well so that we have a common handling for both kernel and user queues.

Apart from that it looks like it should work now, but keep in mind that this is only the first step we will probably need a second step on top of it.

Regards,
Christian.

> +
> +			userq_range->bo = amdgpu_bo_ref(bo);
> +			xa_store(&xa, key, userq_range, GFP_KERNEL);
> +			new_addition = true;
> +		}
> +		key++;
> +	}
> +
> +	if (new_addition) {
> +		drm_file_err(uq_mgr->file, "userptr bos:%lu\n", key);
> +		drm_exec_fini(&exec);
> +		xa_for_each(&xa, tmp_key, userq_range) {
> +			if (!userq_range)
> +				continue;
> +			bo = userq_range->bo;
> +			ret = amdgpu_ttm_tt_get_user_pages(bo, userq_range->range);
> +			if (ret)
> +				goto unlock_all;
> +		}
> +
> +		invalidated = true;
> +		new_addition = false;
> +		goto retry_lock;
> +	}
> +
>  	ret = amdgpu_vm_update_pdes(adev, vm, false);
>  	if (ret)
>  		goto unlock_all;
> @@ -813,6 +891,15 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  
>  unlock_all:
>  	drm_exec_fini(&exec);
> +	xa_for_each(&xa, tmp_key, userq_range) {
> +		if (!userq_range)
> +			continue;
> +		bo = userq_range->bo;
> +		amdgpu_bo_unref(&bo);
> +		amdgpu_hmm_range_free(userq_range->range);
> +		kvfree(userq_range);
> +	}
> +	xa_destroy(&xa);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index ded33fe76e1c..795b38d0353d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
>  	struct amdgpu_bo *obj;
>  };
>  
> +struct amdgpu_userq_hmm_range {
> +	struct hmm_range	*range;
> +	struct amdgpu_bo	*bo;
> +};
> +
>  struct amdgpu_usermode_queue {
>  	int			queue_type;
>  	enum amdgpu_userq_state state;

