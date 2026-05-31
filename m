Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65561CD6E52
	for <amd-gfx@archiver.kernel.org>; Sun, 31 May 2026 12:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C0F112B30;
	Sun, 31 May 2026 12:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2SHXTBp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5696D112B30
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 12:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3vPawziQaQGmId9Sn04OcFSFry7umzORFsqnUJxBJ+J0nt+9QbLcfLsnoemqpnq03uiLKTKgzhV5IiV+zCEvkmwC7hZgP3Zac9h4wDqZsHpy6KemZIusrPR8sRwHVyRPpqxIk4BcVPstqmmxGExZQfj4yWMD8lAu6khZKL8ufHdKr+OHiiZ5WySFRnqPTOI6yqG5zCSWsAignIJoFsn+LAqGaAe0ig1C989m+9ThbyMdWoz7AKgFhYyATyY5Y6Ltf2itrpjbtkpoKaw8UMUNRNUAIMsTSLevLVX7+jHOdqt7T4nOWfMrHwIWmL7ijKVNbk9Y0dFNMb3/moChY4Xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqLFbDwyhwjzgh+h2pL79Suw1rELPE0hdZYCD9cbUiE=;
 b=GO2Pr0G9SzkKHADqHzgQ31k+sPcHkTVABAfh+PuLOtqxr1t+PVWlAtJmrQpWoiFpbdmfdegZV8EXJNkDEkigUOiEJnHD9jLQeECZFb/0JsFIXNtkSk6mHk20HOVfdQ/NSg66SZRs6u3Kim9tCzjzqTNxyaGWi6iOn25Hzae+2HuPLTGcZiWkDjLbl8o6siOBd2tgOB2e8RgxU3kHsXymEJGdkBrNgGzs07T0qRGwhVRaGku8tDbARZz7iKkl2RlTbksJyA9Z6YtPFKDKjC7/rAyfXCQZPfRswU+TDB5xjSAKWmYifD9M8YjKhQcxSCwq6yQBZrfNwzG0xw04Ff2POQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqLFbDwyhwjzgh+h2pL79Suw1rELPE0hdZYCD9cbUiE=;
 b=W2SHXTBpb2EtvWEottiupCV5NwwR0dFFg1IF6YbVO1UuChTJcy6RfyCw2UO7XgEppSclOdLDkbrb1nfFh8zaz9w2ZX/Hw3eKu1kUHhITeRzLke4FLLYsv68+UgP9CZu4o1UlKJKcRyunudiW1xZZTsgC23WrStZeg+7px/BgVR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 12:57:46 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 12:57:45 +0000
Message-ID: <4810ae14-8580-438f-ad3d-d7c7d8e7d6a3@amd.com>
Date: Sun, 31 May 2026 08:57:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd/display: Retry link detection when it fails
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260531105744.28717-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::8) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 9241aaca-5373-497c-b1ec-08debf1435e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: fVmFoBVs1wxRdPi2J7Bx00obgDRoUiDLsQBVO3uGdtiRn5KIiV8xIhjOOctdtUYOgCVdvu+dD7HxSNexyv/6VFmacabgj5agDHJNwcAkMQuK20JdOFofSNRxoPzQ87yMyft9Y4/v1FsFB0VoQsSiX0JzgBtHJOOrf0CwD9NAD8+ztAW5lL0m0FYfCcYQi5xgW5pVJVprlyh41fKyPOIW1a/YLAOD4yL+RQ+I57DmSwkEqQTJhZSeRbOgi8ejhTnGGfcUpmb936k15VaymPHfJWAUy3z2AAqHWrfD8t3yjLjxUw6XX6jJ2+I428OZMAyZL9+kPbwuTsTAm7iLNcWswn5+cBISEjonGTuGikEv9kXEnpP34129MUEKY7tbpQzBb+DQJYtxqbPm11FpFTl1zUuLfxqYeFFiNfLwooiay3frHH0sIJwSTrsD/uN5H9oMuX2ShlLt1urDpFaGes9hv89bgM6hANLs05Pa7reA7t8uegKFlQ77FYgqgPFxjV1Y/NQd3b2w8QLnMmtI24jK1YkycxOwrg7zWFGcFdDbTzEIPNcot1Lq6d4NfArQ1q2GThpIEpu2hNperdn8l9itJZiG+xIYo/7+AD3B9LbQAwUD1LbR9Jap/fe7vcwP7dMrxlJvFW8yI+pXkPL38JzhrxeBX7GNv9l371sVz6kyKXjXPzUrCLSeJn4YSPQ05I90lK0oXLxu/8isnpT69FnkZpHimv6umrHrZOy26tNX1AeRY75TJUvCqf9tyV/7BMMb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE5DaC9zb2hqcjc1K2dIQk4vd3ZmZzVtRWVHbW9ZZlFBajIwZEVyZmdzbXhp?=
 =?utf-8?B?Rlg1dHZ1dzdzTFpjeFc2ZG8rTXhvZ0RRNUhDUWlFbkowb2N2Sjl5NUtZazRn?=
 =?utf-8?B?SjhscXVySEE3VDUvWlhROWgwa1JNbkVKOWc3K2RqakZjVzlQZ0cxN3dXUWo5?=
 =?utf-8?B?d2ZmOGdnZkM4alRqSjhCandLUXhmK2VSM3VaSndmd09mSkV4dC9mQVgyQURQ?=
 =?utf-8?B?a0NiQ3duUTltZndqN3NVdWdJT1ZxR3BnVjE1a2RjZEdHN2ZPWndvWENRc3JU?=
 =?utf-8?B?RXN0MnowVlEwZUV2Y1lCclREYWppNXNoYnI0RnZrZll6OXhCUnEzNVhRV3hs?=
 =?utf-8?B?YWJMbDQwWnU3eW40VFhNUGNiZ1JDYlZHbWUzc0RQWU9FQW5CQlhOcHdwVzQ2?=
 =?utf-8?B?blA3Q2NoUng2Vm5TWFpROVJqSnZCQWdSd0VrM3JGbHFuUkJySXh5ZzJFa0xp?=
 =?utf-8?B?WlpYWEpRSTkyZWZKNDc0RjFxSFo1Zm41UEh3aVQ5YUhlZ1ZsZUQyZW5RQmln?=
 =?utf-8?B?U3FmSVlpdzU3b2VRU1prMHF1S2k2Y05OUDErZ1lCUG9XeXY2bzJHNkcydkNr?=
 =?utf-8?B?VGRaZ0VKdU1tOXZCVGN2T09YdTgwZFdxeWJrNXZCVVdFblpIbjhYb3ZzcmJj?=
 =?utf-8?B?NjkyZ1dsZ01JV09XcEZIRUxOc3Iyc3dWMjVqQjdiUXpGZjlHdEpVdFZVb2do?=
 =?utf-8?B?dndLU0p5ZWtUZ0RBWEZmUkx5ZXNzRFltK0J6TFc0aWFqSVgzNG85VE9Eamwx?=
 =?utf-8?B?NzNOVHY2U0gxeUNhYS9MUGJOenB5VzZoT2xGbXBNYzIrZXFDREJFZnk4Vm9m?=
 =?utf-8?B?SEVaWnBlcnNJN2l2ZTVBUTFxcWQvcUc2NGRIK3dpZEtFdGZsdVQyajJMZGxS?=
 =?utf-8?B?akFFU3hWclVQUTNBSHNsYXBVUFM0QkRsYTJBbTN6K2NRbXhtZ1AzbThHWE9K?=
 =?utf-8?B?QXVXY0FOZldIaE5rSnJRR2tjWmt1ck9CcmgxejBONjVoQXE0MTVOL1I3dVd0?=
 =?utf-8?B?QXU2dkd6M1JnUm5mcnpndno5NncvTFN3M1Y0UWtmQi80S05WRjVKT1VjbTk2?=
 =?utf-8?B?c0ovaTViNkRtelZ6MDdBbi9SRld5MjZucVRnL0wrbEpTUk0vZlpYaGxOTXRX?=
 =?utf-8?B?L1JWTnlYWGpoQ2t5bWU3VzVPWExZTGR3ZDJMVHpZMHFuekV4ditwSmtwbFA4?=
 =?utf-8?B?bDJ3SUxidjBXYzlROWxTUHdDYmh4THlmVnRpcEJnT05rUDQyVkFBVEo0RmJ6?=
 =?utf-8?B?V2VOaUZOU09QRmNneWIzbDdGT2UyYVduMVN2aFQ2cnRVTDliVUVWT0kxQUFQ?=
 =?utf-8?B?V3NrcWd2dWtQR2hXN2FUWlhlNG9tOEFTVnozZm92QjcwMWoxOFlnRUUvc1dH?=
 =?utf-8?B?Ry9vLzVjZUxDRzlHN1pEUGtUUWs4bGZnZUVKN2M0T1VOZVliUHdEUzRyMmJM?=
 =?utf-8?B?WUM3c1N1ZUVPbTlOZVJJek54SWY5Y3hTN0tnUzBwaC9xRkZCWEFrYkQ5Ulcv?=
 =?utf-8?B?cGVocnN3eVk2OFlzNjY0anMvTlpuaStYWWVZeDJWZllUMVhnWFlCcHIwQ3hD?=
 =?utf-8?B?OGZOdnVWMUpqS0pFaXNreEVLZzFYa1VONkhwNWo4a1hWMWg5MFRVNnBCVlpF?=
 =?utf-8?B?K1RjNHk5NVczSFBvZ3lJVGdsSk5BdGZ1YVV3aitQeUhnT25YeTJIWEdWSU9X?=
 =?utf-8?B?aTRZMEtpWG9zbUNza1g3M3Mxa29uWmlnWlBJOEMwU3k1dXhSaFlOVHE5UzVK?=
 =?utf-8?B?YkVZMXhsSXRXc1p5OEpTUCtpT2FxNE03dU9qT0V1cW5hK0NLNjZLMGFTeENI?=
 =?utf-8?B?TTBGVGE2N2FrZVo0ZFJ6QkoyVHNScGlqTUl0cXZzUVZ3SmRFa1ZMTURBNUNL?=
 =?utf-8?B?dE5VNllsWVhwak1XWUpYVFl5MmNuTWZaU09wbENGZU45czBqaU15KzBJUTVk?=
 =?utf-8?B?TVhxL3lLS1BrZ25mNGtLeWx2TXRXNVlPbXRDRVdOR1p3dmJpMmY4SnQ1K2R6?=
 =?utf-8?B?Wk5xVnNIdkMramVIWkhpbDJBcHUyR2VxMnZuZlJ4MFFkUFg0RCtZdkxZZUxL?=
 =?utf-8?B?bkM1ZHZNRk1wUnZiaHEzN00vMFJ3Y3pHSHJINDMybjdFK2g1cWtyS2lUNzJX?=
 =?utf-8?B?ay82MnRvdk84aGlkTmcyQUFoTGsvVDg1QzBhWitPeW5PVjQ5N0VwT2ZIQnUr?=
 =?utf-8?B?QU1EeFREN3NPWnJTN0Z6L2VVeG5TUlllQVpLQ1hDQUk4OWYvZUF3RStsUkh0?=
 =?utf-8?B?N1VwU3ZBMlVNQUh6Y0wvMy9iNmZ6dmZOOWkwWW5nTmgzVkNvc3FPdElwQVow?=
 =?utf-8?B?bm96Zm8xNldiSUFyV3ZaZTE1L0tOMmQ1Y3JhRzR1RDJIRzllSEpNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9241aaca-5373-497c-b1ec-08debf1435e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 12:57:45.8865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8z/rih+8u/MNc8NB3DmFoBn3CEAi9sEDFVBPDYGiQn4h+mfI9aBt4zSFfWUFB2KnK4+IMVpj2eniiAHBRLaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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



On 2026-05-31 06:57, Timur Kristóf wrote:
> When dc_link_detect_connection_type thinks that a display is
> connected, but dc_link_detect failed, enqueue delayed work to
> retry the link detection again.
> 
> Useful when eg. HPD pin is high but the display isn't ready and
> didn't respond to DDC. Typically this may happen when the HPD
> pins make contact before the DDC pins, or when the display
> is "slow to wake up" and doesn't respond on DDC.
> 
> The first few patches are just a slight refactor to
> de-duplicate some code and do some cleanup necessary
> for the retry. This is to avoid adding even more duplicated
> code.

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Dan, can we queue this for testing in the next promotion cycle before 
merging?

Harry

> 
> Timur Kristóf (5):
>    drm/amd/display: Add detect reason to handle_hpd_irq_helper
>    drm/amd/display: Use handle_hpd_irq_helper for HPD RX
>    drm/amd/display: Always create delayed HPD work queue
>    drm/amd/display: Retry link detection on hotplug
>    drm/amd/display: Retry link detection on resume and boot
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 216 +++++++++++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 ++
>   2 files changed, 179 insertions(+), 53 deletions(-)
> 

