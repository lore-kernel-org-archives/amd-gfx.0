Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF623C3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 20:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571DE10EB59;
	Fri, 16 May 2025 20:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6Fa9LzI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4AE10EB59
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 20:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS13nSFciaXEGdYN04Q9nPNCCS6Rwjc+9LaXyCX7/gHHSInNuUpd8hFF0WGeFn5zbu5BJRofgZGfrNe3FIRB4b3rEslOWwwP+5YBE1EDuNuLrTiqyesOH8mCjIMd2AlTxMpkcAgXcexuuwyOgcgU7ZrAjZCt8Fk7ff7I4tT+BBkVbd+9Q1Th/z+Bab0Octyjmz7ZS8EeyxbBOrKckWc6Z5Ou/Ihydrup/JDuT+rP/cZTMo8AV3PsIWQ638EN3stserAoYYMnRb34DE3a//9MQ7HphbgzvTulQjLqbx5i/hvvy8PbW+/4NItzdQx7YpfcKaK+7Ily2nmmtw37fe3ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whKNGyrYffUj5ItMOOCqbIPS2ZhJnOto01dmW6kD6Dg=;
 b=OaIN+/gbMfQ9+8ZR9RLXI/Jr3wTUGTYaqp18CI5szovaeExhOKjbCTGZP10DzlT0X/AsWSZIGeuu2+fbyAFkh/pq0WFcNXVwpSf21JbZw4Kn8pJfo3L6x+x4wSITh+OVxuJhEt2hLDuDeUvrPrsYk986dy5mV7OzS4HMBYQv7cT6PpJb9R0tERZ2DX8dEL2K+0KUkAhJ4emq/0VE1iVTERI4H84QJGcxHZLf++PsJca6weAwuW0cukRD4wEwwmcrls5U1q9eTjhh8zBMz0GD76mBWW7kcNPPA5hRu1kj08kv5Z1lOYyMxKr+L5JnATZLn6Cux6Z5WgmGTHuRR3gM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whKNGyrYffUj5ItMOOCqbIPS2ZhJnOto01dmW6kD6Dg=;
 b=y6Fa9LzIWzmTPf7s7OSOAADrxCzTzq4K+b9C3m3cbeYtFS1/YFGg1uZqWGpT7p8f//bJmuszuieOEIQRt9euXg/8G+eG8JtlDgXJPo1lEyh09IU9pnM5XhTK1rFzP0W56f3+oI8Luw8nnPPDu09MMOYAZ8nXaXXyvvnQCI7m3f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Fri, 16 May 2025 20:58:29 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 20:58:28 +0000
Message-ID: <efd46968-3658-4330-bd55-d56373b96eeb@amd.com>
Date: Fri, 16 May 2025 16:58:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250515221656.1516157-1-pratap.nirujogi@amd.com>
 <05d8be92-4779-46a6-b8f1-71e71c33a258@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <05d8be92-4779-46a6-b8f1-71e71c33a258@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::19) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: fc507cf8-c2b9-4baf-ce5a-08dd94bc6881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUl4cjRVNEsvdi9LZ3FaQzNPOHJjL2R3U0g5VmhUcTlMNkE1b3BweFUySUJC?=
 =?utf-8?B?amg0c00xc3JUSVFoUzZWNUlpdi8veUN2VnBjV3p1M1o0R3Q0TlJTMU1XL3pk?=
 =?utf-8?B?YU9vM0RUb2VIdVRrOXRZYkdRMTE3OVFwbmhzLzArSnd4cE5NQ0JlYVZ5TFpk?=
 =?utf-8?B?VXBhS3FsZFQ2cjU0cHdRbVpRME9ZWGhPR0s2eDJiOW9zcXlobmtNVjE1SVlm?=
 =?utf-8?B?MkwxbGJzTlR4STQ5emF3cko2bjdkSUR0UmRUNzhTQ3pkN1QzdFd6NXJpalRT?=
 =?utf-8?B?MEdwRno1V1ltdUQxZlRXbSsyVFFzdWxSbDBIcWRsRS9xWVhzY1g5VVpmcE55?=
 =?utf-8?B?cHlvc2RlTFBxOFFlRmVzVzlTRzVxMlhwTzk5Z0ZkVmg0cDJVYk5Pek1zdDFi?=
 =?utf-8?B?dHlYTG85TlNPOUNFbmhnRkUrVVhLV2dwenA1VHZzcnRYZEt6ZnB2YXZtRjVC?=
 =?utf-8?B?WDgvWW9pMTU2UUtoL0UrcTBqT05OTExLUXF4Y0Z3czFzdGhON1c0SWVNTTBN?=
 =?utf-8?B?azVOUkw4dDlNazk0YlBFcXFxMlBKTW5HbzFhZ0lTb3ovaFUvdFRERzBkTXlO?=
 =?utf-8?B?bVlQKzJEOXYwNExXVUkxOTMzTFpaUENaMFdmV2lrQ2F3dVUxaFdCRTR3OWJt?=
 =?utf-8?B?TGx3SkEwcFQxOElPT1oyOWZkd1VOU2hPYXBPZGhNbHpvRGdieDBSR3g5cmNn?=
 =?utf-8?B?ZG16VEp1RVNYc2pGR2trN285N1FJaHplWXJUQy9iVmRFMGRoUklkeWRuQmx1?=
 =?utf-8?B?R0thYys2WFZzRnRkVFgvS04zUFRjKzM4aStBZjV3RGJQbERuYXZlTnhZaGM5?=
 =?utf-8?B?V1R4RlVjeVkxbFhHeWdUNENaQUh0cTF4a3dDVGtuM3k1NmxJaHk5Qkx4VmY5?=
 =?utf-8?B?Vk5qVm4rMERrOFZweVdlQUlCU3dnMjJ0ZzBCdGlBNEU2WFFESGxYNmNJRlVF?=
 =?utf-8?B?TkpFSFNxZUl6dGF6Ui92b3QyZFRkNU9wbjBLQVZMRFJnNUg3UERYSXIxbmxF?=
 =?utf-8?B?WFF1Yk9DTWpwdllaakh5YWg1UFJTczJ3MWgxYnVtdnYrV1dYRnZaMGhaR2NH?=
 =?utf-8?B?UGUyMVFzZWtKaU16cFdHYTVDczhZNnlNWUpZYzAwUFZHSW9hL2ZxS2h5Ymsw?=
 =?utf-8?B?akRqbWxTT3ZCWFlLbVV4S2YxVXFGRzlIaTlKSkc4ZXZCS1NlbFExRkxzN3ZS?=
 =?utf-8?B?U2RyRmtZakRlMzdXUUtzRW4xd0JmeUhhdzBBZVlFVWY2L1NLcHVRa1dUc2xK?=
 =?utf-8?B?eXdCRHVEazl4dGxFaTh5R3Z4WmErTmlpVUl2blhTcHAyQm9Oc205Y2RqbUhy?=
 =?utf-8?B?MjRkeVVRWVJ2cElsWXZ3dHVyL2ZveEQ5aHlmaWJ5QWtJTnQ2M3hUYlR3SXFL?=
 =?utf-8?B?b2hVeGVtck1rditLa0FQcWVHSTdOVjFzTlJTOGl3RnM4K0VUVUhWYjVjdERi?=
 =?utf-8?B?NHNOa0xOUmhOMDF6UEM5VkgvZ3Fkai9obHluNW1lTUtVbDFaRHJHc0k4K0FM?=
 =?utf-8?B?TVU3VmlOUHdoTFdvU1VTZXFJUGNsbXlLNFZjUXN1RFM5WlVlYmE5d0JFc3pR?=
 =?utf-8?B?blRhU3JJYlhUTTZsbm9lZFl1WGZ3K0VqeW4xZUJ3bXlEdzl6ZFUzeGNiZC8z?=
 =?utf-8?B?U1dFd0NGeStvejJDOG5GcTlsWVlKSkMrTFRidzk1TkZiVENlNUZ3bWhaNTdQ?=
 =?utf-8?B?a0JpTFdhVUdjSU9CbitSd2tMSEhLTTJEenBxM2xHd0owQ0lkYW45UllsZzUz?=
 =?utf-8?B?SVFCSktoOVg3UC9xandEVitSTGR4TFgydU82QkZiTzFVU1RwZFBQelF1NXVS?=
 =?utf-8?B?L3JUK29QZ3FGSFBCMVk5eWpNbWh4aWxQSDB1MGNhUHZMOExQZGN2SVl1K2tK?=
 =?utf-8?B?LzlMTTN2YmdWUEdDazM3Wlpma2gzVHZ4eWlMZytPK1NrdGFXZnllV1hjWGFa?=
 =?utf-8?Q?GKgaSqTWugw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVROcUpDQ1dBUHJROFJwOWVyZGJGb0NPMUhTUk1zOVgrbU5MNnBvUXZOMHlU?=
 =?utf-8?B?YW53a1A5aTZtRU9NTjBlbXhuRWthY0oyY291V3dXUkVKeE1aV3hqT1MzdkI5?=
 =?utf-8?B?RzV4YkdtS3dkNlJncTJCUEswUDR1YmlQdFFQdXVLSWhLdlpUbGhESW5BSjZ5?=
 =?utf-8?B?NTJuTUJrN3FUM3ptZHpWcUpFQWl6RDRkOGorSE4vMHJ0Wmo2WkJIOHdxNnhY?=
 =?utf-8?B?UUl6RStqNkdjNTBuR3JLTENEUTV6dE9HT0NDTGphN0xoRjVtallVd0kzT3NB?=
 =?utf-8?B?d2Z3VVJJOHVEYlpCbnVqdWdiUUQrcUxKenk3ZG5COS8zd0lUdzJTelhIQW5E?=
 =?utf-8?B?dzRLSm54ODE5Skk0SEZCN1dUWXJCYTVHc28xV21UcXBsSkFhNmtVdUhsMGRz?=
 =?utf-8?B?bjUzT0E4aWFQTyswbWpEckxKMkJORmNUNzFhTzVOa3dYbU4zQ1BEbFU1MG0z?=
 =?utf-8?B?ci9MQy96aExGMS93dWxuNzIvNDRCMkNuM0VvNEpkMi9pWU50eHNjOC9lOHpw?=
 =?utf-8?B?N0lLUUhlR2hSdWc5TkQrOFVQMkVuMjZNYUNrVTBNbUxSSlJQZTJCakVvMFZs?=
 =?utf-8?B?a2E3L3gwM0F4bWlneEk4MGJ2RXgwMTgxTENCWGZvZGxSUlcvQU1IZFE4WFp6?=
 =?utf-8?B?RURCTnp4Z1JGYUdzTmMwcWoya29jZmlzZmlLWFI5VmJQci93YTNBaDdqdXQy?=
 =?utf-8?B?TGRiTGczU1oxQ0NkVUVEV2FqdG1UMVVjakVtLzRoamtxTzE0bEpsQzNtVFU4?=
 =?utf-8?B?dkhMUjR2VzgvMWRRU2JKMldlWGlzM3BsQnlDZDZVWWZwMisvMThUd0prd2gr?=
 =?utf-8?B?aEs1OTBNQXhuZVhYRHh0QjkyTGRERTdCRGw4RzZSNkRFZmZybTJnVHdkWmEw?=
 =?utf-8?B?MXBxLzZDVFIxcDdPVHo3VnQxRkdnT01LT1l3ZlBxVXJ0NENKdVdFZCt4bVZ4?=
 =?utf-8?B?b0lxQUFWNXdKNWUvN1FXcytSUXpxZmY0dmR1S2k2MzREY3o5VFZtRENkWmxu?=
 =?utf-8?B?L1BWbVZERktmOHZReDVFZGpmaFkvSnNNSDFyWUUvb2pyT1ZYRmMvaE41dkdr?=
 =?utf-8?B?WmxTYjA3MGxaV1RRRVZLVnFoa3U5NUdUa3dKL1gvMUwrQnNaT0FxV2Y2U1Bn?=
 =?utf-8?B?TzdCOFlaM0FtcThnVTVTMzRWZUJhTk13YlVVRmxKdkpXL0lGNkRXMEpQdk4z?=
 =?utf-8?B?ZmhUOW9rZ2pSNHVBSHBuK09JSVYwY3l0SFBtOUY0bHprSCtDck9YRHA1VitL?=
 =?utf-8?B?ZWRSL3JHRE5wOThqemVZWTNWN3dST0o3VDdweGFmYVlyT2piS2UyeXp0Nnls?=
 =?utf-8?B?S3ZZT01LT3BnWXZEOGMvbndMNzhlOUQxSXlWU1l1M2x1djFxZUlLSXFEQjF5?=
 =?utf-8?B?T2hPTWEvankzS1hBcENHcEhFd0Z1NS9XRm9aVG5SYVNLNmx4c1VkZmRYUk5r?=
 =?utf-8?B?ZW9HME41L1U4ZVZGRGNUdU5xaUErMXVOU3hZR3JEaUlsS1dnZm50dVN0NkhU?=
 =?utf-8?B?TFZTTHFkRWpxdERCRmUvR0t6VUZNcTNialFNV2QwWEtWNmVObkJSWEw2dzI0?=
 =?utf-8?B?T1duWFF5VHdJSmtTdy9MbEFieXhPN2lVcXJPeTIyUUVqVDVwREtKczh0NmdP?=
 =?utf-8?B?U3owYjJUcnpjMGZJajBYMFpzTFRaT1JpR2JIQlhwSjcyMnlUWFF0dVFORzZ2?=
 =?utf-8?B?VWRvcUpHL1UwWisxWFhwY2VuVjBmYUt1RWhnQ3hNME81aU1Hb0k0M3lDMjZG?=
 =?utf-8?B?UlNWL1Y2c3RVVlZiMWZDOGJYSGdMZWtkMzhSVlh1QUwzWFZwYjBrL0JSKzBG?=
 =?utf-8?B?Rk9JUkhUNFp3MlJlWGJncytsQytGb3lLR0w1VE9EUnVoKzlWZW9IWUxEb1Aw?=
 =?utf-8?B?ck52TjlHemRSQ0ROYlZDKzdlaUdFMU9GdG9WM2hqeURJc0tHMkpsNW1JbHBC?=
 =?utf-8?B?WW02S25xTzVSUTQwa1FOWC91RDE1dDJCYjB0RDlmcjU5NlU3ZnZuK1BSK2tJ?=
 =?utf-8?B?dXBvRlRqNk5rVU1rM1N6YzJSSWhYTjZOQ2Z2TmdOVndzTGxUM2RPZjY0cW4w?=
 =?utf-8?B?MzdkRFFDbldtcjNUZ2xYbzNrWmM5WURvOGRyYVFCUzJYdVR3RVZYUUZQYUFr?=
 =?utf-8?Q?6q8ueVLhjb/gSqoiC+rfHInZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc507cf8-c2b9-4baf-ce5a-08dd94bc6881
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:58:28.7008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE5BbrGC6FFDYyA9MKjHs+izYm/oKGuwpVdSOgGHjaqd11XuEbtOcwnxLgZErLMIBYAVH+kVA7uKhTaLjKAxJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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

Hi Mario,

On 5/16/2025 3:42 PM, Mario Limonciello wrote:
> On 5/15/2025 5:16 PM, Pratap Nirujogi wrote:
>> ISP is a child device to GFX, and its device specific information
>> is not available in ACPI. Adding the 2 GPIO resources required for
>> ISP_v4_1_1 in amdgpu_isp driver.
>>
>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>> mode.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>> Changes v1 -> v2:
>>
>> * Use fixed "isp_dev_hid[ACPI_ID_LEN]" instead of allocating using 
>> devm_kzalloc()
>> * Instead of "pointer to pointer" use "pointer to array" type arg in 
>> amdgpu_acpi_get_isp4_dev_hid()
>> * Include error code in the debug statement
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu.h
>> index cc26cf1bd843..2aa7e89a190e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1657,10 +1657,12 @@ static inline void 
>> amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>>   #else
>>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev) { }
>> +static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
>>   #endif
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index b7f8f2ff143d..c39d3a09cd04 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev)
>>           adev->in_s3 = true;
>>   }
>> +static const struct acpi_device_id isp_sensor_ids[] = {
>> +    { "OMNI5C10" },
>> +    { }
>> +};
>> +
>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>> *data)
>> +{
>> +    return acpi_match_device(data, dev) ? 1 : 0;
>> +}
>> +
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
>> +{
>> +    struct acpi_device *acpi_pdev;
>> +    struct device *pdev;
>> +
>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>> +                   isp_match_acpi_device_ids);
>> +    if (!pdev)
>> +        return -EINVAL;
>> +
>> +    acpi_pdev = ACPI_COMPANION(pdev);
>> +    if (acpi_pdev)
>> +        strscpy(*hid, acpi_device_hid(acpi_pdev));
>> +
>> +    put_device(pdev);
>> +
>> +    return 0;
>> +}
>> +
>>   #endif /* CONFIG_SUSPEND */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index 69dd92f6e86d..574880d67009 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -25,6 +25,7 @@
>>    *
>>    */
>> +#include <linux/gpio/machine.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>> @@ -39,15 +40,45 @@ static const unsigned int 
>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>   };
>> +static struct gpiod_lookup_table isp_gpio_table = {
>> +    .dev_id = "amd_isp_capture",
>> +    .table = {
>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>> +    .dev_id = "i2c-ov05c10",
>> +    .table = {
>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       struct amdgpu_device *adev = isp->adev;
>>       int idx, int_idx, num_res, r;
>> +    u8 isp_dev_hid[ACPI_ID_LEN];
> 
> I don't think this is going to happen in practice, but because this 
> isn't initialized you have a case that the ACPI_COMPANION() isn't found 
> and thus amdgpu_acpi_get_isp4_dev_hid() returns 0 and there is garbage 
> in isp_dev_hid.
> 
> I think it's best for amdgpu_acpi_get_isp4_dev_hid() to check acpi_pdev 
> for being NULL and return -ENODEV to avoid this risk or isp_dev_hid to 
> be initialized to NULL.
> 
sure, will add the check for acpi_pdev to avoid the possibility of 
accessing invalid isp_dev_hid.

Thanks,
Pratap

>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> +    r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
>> +    if (r) {
>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
>> +        /* allow GPU init to progress */
>> +        return 0;
>> +    }
>> +
>> +    /* add GPIO resources required for OMNI5C10 sensor */
>> +    if (!strcmp("OMNI5C10", isp_dev_hid)) {
>> +        gpiod_add_lookup_table(&isp_gpio_table);
>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>> +    }
>> +
>>       isp_base = adev->rmmio_base;
>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
> 

